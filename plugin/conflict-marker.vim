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

let g:conflict_marker_enable_mappings = 0

nmap ]k <Plug>(conflict-marker-next-hunk)
nmap [k <Plug>(conflict-marker-prev-hunk)

nmap <leader>cj <Plug>(conflict-marker-themselves)
nmap <leader>ck <Plug>(conflict-marker-ourselves)
nmap <leader>cn <Plug>(conflict-marker-none)
nmap <leader>cb <Plug>(conflict-marker-both)
