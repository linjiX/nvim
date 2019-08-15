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

nnoremap <expr><silent> <leader>zz buffer#Open(":Files\<CR>")
nnoremap <expr><silent> <leader>zb buffer#Open(":Buffers\<CR>")
nnoremap <expr><silent> <leader>zg buffer#Open(":GFiles\<CR>")
nnoremap <expr><silent> <leader>zG buffer#Open(":GFiles\<CR>?")
nnoremap <expr><silent> <leader>zo buffer#Open(":BCommits\<CR>")
nnoremap <expr><silent> <leader>zO buffer#Open(":Commits\<CR>")
nnoremap <expr><silent> <leader>za buffer#Open(":Ag\<CR>")
nnoremap <expr><silent> <leader>zr buffer#Open(":Rg\<CR>")
nnoremap <expr><silent> <leader>zt buffer#Open(":BTags\<CR>")
" nnoremap <expr><silent> <leader>zT buffer#Open(":Tags\<CR>")
nnoremap <expr><silent> <leader>z` buffer#Open(":Marks\<CR>")
nnoremap <expr><silent> <leader>zm buffer#Open(":History\<CR>")
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
