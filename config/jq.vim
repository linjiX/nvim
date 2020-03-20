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

xnoremap <leader>jq :!jq -M -r --indent 4<CR>
xnoremap <leader>jc :!jq -M -c<CR>
xnoremap <leader>j\ :!jq -M @json<CR>

function s:AutoCmdJQ() abort
    nnoremap <buffer> <leader>jq :%!jq -M -r --indent 4<CR>
    nnoremap <buffer> <leader>jc :%!jq -M -c<CR>
    nnoremap <buffer> <leader>j\ :%!jq -M @json<CR>
endfunction

augroup myJQ
    autocmd!
    autocmd FileType json call s:AutoCmdJQ()
augroup END
