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
let g:tcomment_maps = 0
let g:tcomment#blank_lines = 0

nmap <silent> gc <Plug>TComment_gc
xmap <silent> gc <Plug>TComment_gc
nmap <silent> gcc <Plug>TComment_gcc
nmap <silent> gcs <Plug>TComment_gcb

map <leader>cc <Plug>TComment_<Leader>__
map <leader>cs <Plug>TComment_<Leader>_b
map <leader>cr <Plug>TComment_<Leader>_r
map <leader>ca <Plug>TComment_<Leader>_a
xmap <leader>ci <Plug>TComment_<Leader>_i
xmap <leader>cy ygv<Plug>TComment_<Leader>__
nmap <leader>cy yy<Plug>TComment_<Leader>__
