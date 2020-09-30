""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/nvim                                "
"     _  _          _  _ __  __    __             _                "
"    | |(_) _ __   (_)(_)\ \/ /   / /_ __ __   __(_) _ __ ___      "
"    | || || '_ \  | || | \  /   / /| '_ \\ \ / /| || '_ ` _ \     "
"    | || || | | | | || | /  \  / / | | | |\ V / | || | | | | |    "
"    |_||_||_| |_|_/ ||_|/_/\_\/_/  |_| |_| \_/  |_||_| |_| |_|    "
"                |__/                                              "
"                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:asyncgrepprg = 'rg --vimgrep -F -U'
else
    let g:asyncgrepprg = 'grep -H -n'
endif

let g:asyncrun_rootmarks = ['.git']
let g:asyncrun_status = ''

function s:AsyncGrep(cmd, args)
    let l:args = empty(a:args) ? expand('<cword>') .' %' : escape(a:args, '#%')
    execute join([a:cmd, g:asyncgrepprg, l:args], ' ')
endfunction
command! -bang -nargs=* -complete=file AsyncGrep call <SID>AsyncGrep('AsyncRun<bang>', <q-args>)

function AsyncStar(is_visual, is_global, is_g) abort
    let l:pattern = '"'. escape(a:is_visual ? star#Word(1) : star#Word(0), '$\`"#%') .'"'
    let l:whole = a:is_g ? '' : '-w'
    let l:file = a:is_global ? '<root>' : '%'
    execute join(['AsyncGrep!', l:whole, l:pattern, l:file])
endfunction

function s:AsyncStarCommand(is_visual, is_global, is_g) abort
    if &lazyredraw == 0
        set lazyredraw
        let l:setlz = ":set nolazyredraw\<CR>"
    else
        let l:setlz = ''
    endif
    let l:setpos = ":noautocmd call setpos('.', ". string(getcurpos()) .")\<CR>"

    let l:args = join([a:is_visual, a:is_global, a:is_g], ',')
    let l:starcmd = ":\<C-u>call AsyncStar(". l:args .")\<CR>"

    return l:starcmd . l:setpos . l:setlz
endfunction

function s:AutoCmdCWindow() abort
    if exists('g:asyncrun_silent_mode')
        unlet g:asyncrun_silent_mode
        if g:asyncrun_code == 0
            return
        endif
    endif
    belowright copen
endfunction

augroup myAsyncRun
    autocmd!
    autocmd User AsyncRunStop call s:AutoCmdCWindow()
augroup END

nnoremap <expr><silent> <leader>* <SID>AsyncStarCommand(0, 0, 0)
nnoremap <expr><silent> <leader>g* <SID>AsyncStarCommand(0, 0, 1)
nnoremap <expr><silent> <leader># <SID>AsyncStarCommand(0, 1, 0)
nnoremap <expr><silent> <leader>g# <SID>AsyncStarCommand(0, 1, 1)

xnoremap <expr><silent> <leader>* <SID>AsyncStarCommand(1, 0, 1)
xnoremap <expr><silent> <leader>g* <SID>AsyncStarCommand(1, 0, 1)
xnoremap <expr><silent> <leader># <SID>AsyncStarCommand(1, 1, 1)
xnoremap <expr><silent> <leader>g# <SID>AsyncStarCommand(1, 1, 1)
