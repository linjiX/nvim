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

let g:star_echo_search_pattern = 0

xmap <silent> * <Plug>(star-*):SearchIndex<CR>
xmap <silent> # <Plug>(star-#):SearchIndex<CR>
nmap <silent> * <Plug>(star-*):SearchIndex<CR>
nmap <silent> # <Plug>(star-#):SearchIndex<CR>
nmap <silent> g* <Plug>(star-g*):SearchIndex<CR>
nmap <silent> g# <Plug>(star-g#):SearchIndex<CR>
