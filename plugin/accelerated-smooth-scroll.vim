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

let g:ac_smooth_scroll_du_sleep_time_msec = 0
let g:ac_smooth_scroll_fb_sleep_time_msec = 0
let g:ac_smooth_scroll_min_limit_msec = 100
let g:ac_smooth_scroll_max_limit_msec = 150

" nnoremap <expr> <C-u> coc#util#has_float() ? coc#util#float_scroll(0)
"             \                              : <C-u>
" nnoremap <expr> <C-d> coc#util#has_float() ? coc#util#float_scroll(1)
"             \                              : <C-d>
