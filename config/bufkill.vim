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

nnoremap <expr><silent> <leader>o BufferCmd(":BB\<CR>")
nnoremap <expr><silent> <leader>i BufferCmd(":BF\<CR>")
nnoremap <expr><silent> <leader>` BufferCmd(":BA\<CR>")
nnoremap <expr><silent> <leader>u BufferCmd(":BUNDO\<CR>")

nnoremap <expr><silent> + BufferCmd(":bn\<CR>")
nnoremap <expr><silent> _ BufferCmd(":bp\<CR>")
vnoremap <expr><silent> + BufferCmd(":bn\<CR>")
vnoremap <expr><silent> _ BufferCmd(":bp\<CR>")
nnoremap <silent> <leader>q :BW<CR>
nnoremap <silent> <leader>Q :BD<CR>
