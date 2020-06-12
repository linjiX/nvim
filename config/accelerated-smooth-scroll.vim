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

let g:ac_smooth_scroll_no_default_key_mappings = 1
let g:ac_smooth_scroll_du_sleep_time_msec = 0
let g:ac_smooth_scroll_fb_sleep_time_msec = 0
let g:ac_smooth_scroll_min_limit_msec = 120
let g:ac_smooth_scroll_max_limit_msec = 150
let g:ac_smooth_scroll_skip_redraw_line_size = 3

function s:AutoCmdScroll() abort
    if exists('w:float') && w:float
        return
    endif
    nmap <buffer><expr> <C-f>
                \ coc#util#has_float() ? coc#util#float_scroll(1)
                \                      : '<Plug>(ac-smooth-scroll-c-f)'
    nmap <buffer><expr> <C-b>
                \ coc#util#has_float() ? coc#util#float_scroll(0)
                \                      : '<Plug>(ac-smooth-scroll-c-b)'
endfunction

augroup myScroll
    autocmd!
    autocmd FileType * call s:AutoCmdScroll()
augroup END

nmap <silent> <C-f> <Plug>(ac-smooth-scroll-c-f)
nmap <silent> <C-b> <Plug>(ac-smooth-scroll-c-b)
nmap <silent> <C-u> <Plug>(ac-smooth-scroll-c-u)
nmap <silent> <C-d> <Plug>(ac-smooth-scroll-c-d)

xmap <silent> <C-f> <Plug>(ac-smooth-scroll-c-f_v)
xmap <silent> <C-b> <Plug>(ac-smooth-scroll-c-b_v)
xmap <silent> <C-u> <Plug>(ac-smooth-scroll-c-u_v)
xmap <silent> <C-d> <Plug>(ac-smooth-scroll-c-d_v)
