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

xmap <silent> <leader>k <Plug>(keyword-highlight)
nmap <silent> <leader>k <Plug>(keyword-highlight)
nmap <silent> <BS> <Plug>(keyword-clear):nohlsearch<CR>

nmap n <Plug>(keyword-forward)
nmap N <Plug>(keyword-backward)

nnoremap <silent> <Plug>(keyword-forward-fallback) n:SearchIndex<CR>
nnoremap <silent> <Plug>(keyword-backward-fallback) N:SearchIndex<CR>
