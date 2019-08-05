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

function s:PLCclose() abort
    pclose
    lclose
    cclose
endfunction

" QuickFix window toggle
function s:ListToggle(cmd) abort
    let window_count_before = winnr('$')
    call s:PLCclose()
    if winnr('$') == window_count_before
        execute 'belowright '. a:cmd
    endif
endfunction

function s:AutoCmdQuickFix() abort
    set bufhidden=delete
    silent! set nobuflisted
    nnoremap <silent><buffer> <CR> :pclose<CR><CR>:cclose<CR>:lclose<CR>
    nnoremap <silent><buffer> q :call <SID>PLCclose()<CR>
    nnoremap <silent><buffer> <leader>q :call <SID>PLCclose()<CR>
endfunction

augroup myQuickFix
    autocmd!
    autocmd FileType qf call <SID>AutoCmdQuickFix()
    autocmd QuickFixCmdPost [^l]* nested belowright cwindow
    autocmd QuickFixCmdPost    l* nested belowright lwindow
augroup END

nnoremap <silent> <leader>co :call <SID>ListToggle('copen')<CR>
nnoremap <silent> <leader>lo :call <SID>ListToggle('lopen')<CR>
