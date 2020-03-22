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

nnoremap <leader>jq :%!jq -M -r --indent 4<CR>
xnoremap <leader>jq :!jq -M -r --indent 4<CR>
nnoremap <leader>jc :%!jq -M -c<CR>
xnoremap <leader>jc :!jq -M -c<CR>
nnoremap <leader>j\ :%!jq -M @json<CR>
xnoremap <leader>j\ :!jq -M @json<CR>
