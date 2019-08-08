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

let g:fzf_layout = {'down': '~30%'}

imap <C-x><C-w> <plug>(fzf-complete-word)
imap <C-x><C-x> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-line)
if executable('ag')
    imap <C-x><C-z> <plug>(fzf-complete-file-ag)
else
    imap <C-x><C-z> <plug>(fzf-complete-file)
endif

nnoremap <expr><silent> <leader>zz BufferCmd(":Files\<CR>")
nnoremap <expr><silent> <leader>zb BufferCmd(":Buffers\<CR>")
nnoremap <expr><silent> <leader>zg BufferCmd(":GFiles\<CR>")
nnoremap <expr><silent> <leader>zG BufferCmd(":GFiles\<CR>?")
nnoremap <expr><silent> <leader>zo BufferCmd(":BCommits\<CR>")
nnoremap <expr><silent> <leader>zO BufferCmd(":Commits\<CR>")
nnoremap <expr><silent> <leader>za BufferCmd(":Ag\<CR>")
nnoremap <expr><silent> <leader>zr BufferCmd(":Rg\<CR>")
nnoremap <expr><silent> <leader>zt BufferCmd(":BTags\<CR>")
" nnoremap <expr><silent> <leader>zT BufferCmd(":Tags\<CR>")
nnoremap <expr><silent> <leader>z` BufferCmd(":Marks\<CR>")
nnoremap <expr><silent> <leader>zm BufferCmd(":History\<CR>")
nnoremap <silent> <leader>zc :Colors<CR>
nnoremap <silent> <leader>zl :BLines<CR>
nnoremap <silent> <leader>zL :Lines<CR>
nnoremap <silent> <leader>z<leader> :Maps<CR>
nnoremap <silent> <leader>zw :Windows<CR>
nnoremap <silent> <leader>z: :History:<CR>
nnoremap <silent> <leader>z/ :History/<CR>
nnoremap <silent> <leader>zs :Snippets<CR>
nnoremap <silent> <leader>ze :Commands<CR>
nnoremap <silent> <leader>zh :Helptags<CR>
nnoremap <silent> <leader>zf :Filetypes<CR>
