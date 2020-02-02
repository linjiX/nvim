"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/.vim                           "
"     _  _          _  _ __  __    __        _                "
"    | |(_) _ __   (_)(_)\ \/ /   / /__   __(_) _ __ ___      "
"    | || || '_ \  | || | \  /   / / \ \ / /| || '_ ` _ \     "
"    | || || | | | | || | /  \  / /_  \ V / | || | | | | |    "
"    |_||_||_| |_|_/ ||_|/_/\_\/_/(_)  \_/  |_||_| |_| |_|    "
"                |__/                                         "
"                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:asyncgrepprg = 'rg --vimgrep -F -U'
elseif executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:asyncgrepprg = 'ag --vimgrep -Q'
else
    let g:asyncgrepprg = 'grep -H -n'
endif

let g:asyncrun_rootmarks = ['.git']

function s:AsyncGrep(cmd, args)
    let l:args = empty(a:args) ? expand('<cword>') .' %' : escape(a:args, '#%')
    execute join([a:cmd, g:asyncgrepprg, l:args], ' ')
endfunction
command! -bang -nargs=* -complete=file AsyncGrep call <SID>AsyncGrep('AsyncRun<bang>', <q-args>)

function AsyncStar(is_visual, is_global, is_g) abort
    let l:pattern = '"'. escape(a:is_visual ? star#Vword() : star#Cword(), '$\`"#%') .'"'
    call setpos('.', s:pos)
    let l:whole = a:is_g ? '' : '-w'
    let l:file = a:is_global ? '<root>' : '%'
    execute join(['AsyncGrep!', l:whole, l:pattern, l:file], ' ')
endfunction

function s:AsyncStarCommand(is_visual, is_global, is_g) abort
    let s:pos = getpos('.')
    return ":\<C-u>call AsyncStar(". a:is_visual .', '. a:is_global .', '. a:is_g .")\<CR>"
endfunction

nnoremap <expr><silent> <leader>* <SID>AsyncStarCommand(0, 0, 0)
nnoremap <expr><silent> <leader>g* <SID>AsyncStarCommand(0, 0, 1)
nnoremap <expr><silent> <leader># <SID>AsyncStarCommand(0, 1, 0)
nnoremap <expr><silent> <leader>g# <SID>AsyncStarCommand(0, 1, 1)

vnoremap <expr><silent> <leader>* <SID>AsyncStarCommand(1, 0, 1)
vnoremap <expr><silent> <leader>g* <SID>AsyncStarCommand(1, 0, 1)
vnoremap <expr><silent> <leader># <SID>AsyncStarCommand(1, 1, 1)
vnoremap <expr><silent> <leader>g# <SID>AsyncStarCommand(1, 1, 1)
