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

let s:true_false_pattern = '\v<[Tt]rue>|<[Ff]alse>|<TRUE>|<FALSE>'
let s:oct_number_pattern = '\d*\zs\d'
let s:hex_number_pattern = '0(x|X)\x*\zs\x'
let s:bin_number_pattern = '0(b|B)[01]*\zs[01]'
let s:full_pattern = join([
            \ s:true_false_pattern,
            \ s:hex_number_pattern,
            \ s:bin_number_pattern,
            \ s:oct_number_pattern,
            \ ], '|')

function s:AutoCmdGitrebaseSwapList() abort
    ClearSwapList
    SwapList GitRebase pick squash reword edit fixup exec drop
endfunction

function s:AutoCmdSwapList() abort
    vnoremap <C-a> <C-a>
    vnoremap <C-x> <C-x>
    SwapList TRUE/FALSE TRUE FALSE
    SwapList YES/NO YES NO
endfunction

function s:FallbackIncrement()
    nnoremap <Plug>SwapItFallbackIncrement <C-a>
    call search(s:full_pattern, 'c', line('.'))
    execute 'normal '. v:count1 ."\<Plug>SwapIncrement"
    nnoremap <Plug>SwapItFallbackIncrement :<C-u>call <SID>FallbackIncrement()<CR>
endfunction

function s:FallbackDecrement()
    nnoremap <Plug>SwapItFallbackDecrement <C-x>
    call search(s:full_pattern, 'c', line('.'))
    execute 'normal '. v:count1 ."\<Plug>SwapDecrement"
    nnoremap <Plug>SwapItFallbackDecrement :<C-u>call <SID>FallbackDecrement()<CR>
endfunction

" function s:LocateNumber() abort
"     let l:pos = getpos('.')
"     let l:flag = search(g:true_false_pattern, 'cb', line('.'))
"     let l:col = col('.')
"     call setpos('.', l:pos)
"     if l:flag != 0 && l:pos[2] < l:col + strlen(expand('<cword>'))
"         return
"     endif
"     call search(g:full_pattern, 'c', line('.'))
" endfunction

augroup mySwapit
    autocmd!
    autocmd BufRead * call s:AutoCmdSwapList()
    autocmd FileType gitrebase call s:AutoCmdGitrebaseSwapList()
augroup END

nnoremap <Plug>SwapItFallbackIncrement :<C-u>call <SID>FallbackIncrement()<CR>
nnoremap <Plug>SwapItFallbackDecrement :<C-u>call <SID>FallbackDecrement()<CR>
