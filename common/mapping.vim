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

" normal mode mapping
nnoremap Y y$
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <C-w>m :tabnew %<CR>
nnoremap <silent> <C-w><C-m> :tabnew %<CR>
vnoremap <silent> <C-n> :sort<CR>

" command mapping
cnoreabbrev <expr><silent> q buffer#Quit(0)
cnoreabbrev <expr><silent> wq buffer#Quit(1)
cnoreabbrev <silent> w!! w !sudo tee % > /dev/null

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

cnoremap <C-a> <Home>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" cnoremap <C-h> <S-Left>
" cnoremap <C-l> <S-Right>

" insert mapping
inoremap <C-x><C-a> <C-a>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" terminal mapping
if has('nvim')
    cnoreabbrev terminal botright vsplit term://bash
    nnoremap <silent> <C-p> :botright vsplit term://bash<CR>
    nnoremap <silent> <leader>ei :botright vsplit term://ipython3<CR>
    nnoremap <silent> <leader>eb :botright vsplit term://bpython<CR>
    nnoremap <silent> <leader>ep :botright vsplit term://ptpython3<CR>
    tnoremap <silent> <ESC> <C-\><C-n>:set number<CR>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
else
    set termwinkey=<C-v>
    nnoremap <silent> <C-p> :vertical botright terminal<CR>
    nnoremap <silent> <leader>ei :vertical botright terminal ++close ipython<CR>
    nnoremap <silent> <leader>eb :vertical botright terminal ++close bpython<CR>
    nnoremap <silent> <leader>ep :vertical botright terminal ++close ptpython<CR>
    tnoremap <ESC><ESC> <C-\><C-n>
    tnoremap <C-h> <C-v>h
    tnoremap <C-j> <C-v>j
    tnoremap <C-k> <C-v>k
    tnoremap <C-l> <C-v>l
    tnoremap <C-v>n <Nop>
endif

" quickfix mapping
nnoremap <silent> <leader>co :call quickfix#ListToggle('copen')<CR>
nnoremap <silent> <leader>lo :call quickfix#ListToggle('lopen')<CR>
