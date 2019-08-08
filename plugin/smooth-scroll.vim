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

nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 5, 2)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 5, 2)<CR>
nnoremap <silent> <C-b> :call smooth_scroll#up(&scroll*2, 5, 4)<CR>
nnoremap <silent> <C-f> :call smooth_scroll#down(&scroll*2, 5, 4)<CR>

" nnoremap <expr> <C-u> coc#util#has_float() ? coc#util#float_scroll(0)
"             \                              : ":call smooth_scroll#up(&scroll, 5, 2)\<CR>"
" nnoremap <expr> <C-d> coc#util#has_float() ? coc#util#float_scroll(1)
"             \                              : ":call smooth_scroll#down(&scroll, 5, 4)\<CR>"
