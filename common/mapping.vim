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

" command mapping
cnoreabbrev <expr><silent> q buffer#Quit(0)
cnoreabbrev <expr><silent> wq buffer#Quit(1)

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
cnoremap w!! w !sudo tee % > /dev/null
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" cnoremap <C-Left> <S-Left>
" cnoremap <C-Right> <S-Right>

" insert mapping
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" terminal mapping
if has('nvim')
    cnoreabbrev terminal botright vsplit term://bash
    nnoremap <silent> <C-t> :botright vsplit term://bash<CR>
    tnoremap <silent> <ESC> <C-\><C-n>:set number<CR>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
else
    set termwinkey=<C-v>
    nnoremap <silent> <C-t> :vertical botright terminal<CR>
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
