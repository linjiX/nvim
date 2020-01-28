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

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-\> :TmuxNavigatePrevious<CR>
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nmap <silent><expr> <C-j>
            \ coc#util#has_float() ? '<Plug>(coc-float-jump)'
            \                      : ':TmuxNavigateDown<CR>'

if !has('nvim')
    tnoremap <silent> <C-h> <C-v>:TmuxNavigateLeft<CR>
    tnoremap <silent> <C-j> <C-v>:TmuxNavigateDown<CR>
    tnoremap <silent> <C-k> <C-v>:TmuxNavigateUp<CR>
    tnoremap <silent> <C-l> <C-v>:TmuxNavigateRight<CR>
endif
