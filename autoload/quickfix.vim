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
function quickfix#ListToggle(cmd) abort
    let window_count_before = winnr('$')
    call s:PLCclose()
    if winnr('$') == window_count_before
        execute 'belowright '. a:cmd
    endif
endfunction

function quickfix#AutoCmdQuickFix() abort
    " setlocal bufhidden=delete
    " silent! setlocal nobuflisted
    nnoremap <silent><buffer> <CR> :pclose<CR><CR>:cclose<CR>:lclose<CR>
    nnoremap <silent><buffer> q :call s:PLCclose()<CR>
    nnoremap <silent><buffer> <leader>q :call s:PLCclose()<CR>
endfunction
