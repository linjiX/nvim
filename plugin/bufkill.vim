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

let g:BufKillCreateMappings = 0

nnoremap <expr><silent> <leader>o buffer#Open(":BB\<CR>")
nnoremap <expr><silent> <leader>i buffer#Open(":BF\<CR>")
nnoremap <expr><silent> <leader>` buffer#Open(":BA\<CR>")
nnoremap <expr><silent> <leader>u buffer#Open(":BUNDO\<CR>")

nnoremap <expr><silent> + buffer#Open(":bn\<CR>")
nnoremap <expr><silent> _ buffer#Open(":bp\<CR>")
vnoremap <expr><silent> + buffer#Open(":bn\<CR>")
vnoremap <expr><silent> _ buffer#Open(":bp\<CR>")
nnoremap <silent> <leader>q :BW<CR>
nnoremap <silent> <leader>Q :BD<CR>
