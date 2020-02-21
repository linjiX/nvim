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

" Window Navigator Mapping is done by Plug 'christoomey/vim-tmux-navigator'
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nmap <silent><expr> <C-j>
            \ coc#util#has_float() ? '<Plug>(coc-float-jump)'
            \                      : "\<C-w>j"

" normal mode mapping
nnoremap Y y$
nnoremap <C-p> "0p
xnoremap <C-p> "0p

nnoremap <silent> <C-w>m :tabnew %<CR>
nnoremap <silent> <C-w><C-m> :tabnew %<CR>
vnoremap <silent> <C-m> :sort<CR>

" command mapping
cnoreabbrev <expr><silent> q buffer#Quit('q')
cnoreabbrev <expr><silent> wq buffer#Quit('wq')
cnoreabbrev <silent> w!! w !sudo tee % >/dev/null

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
nnoremap <silent> <C-n> :call terminal#SmartTerminal('bash')<CR>
nnoremap <silent> <leader>ei :call terminal#SmartTerminal('ipython')<CR>
nnoremap <silent> <leader>eb :call terminal#SmartTerminal('bpython')<CR>
nnoremap <silent> <leader>et :call terminal#SmartTerminal('ptpython')<CR>
nnoremap <silent> <leader>eh :call terminal#SmartTerminal('htop')<CR>

tnoremap <ESC><ESC> <C-\><C-n>
if has('nvim')
    tmap <expr><silent> <C-h> terminal#Navigate("\<C-h>")
    tmap <expr><silent> <C-j> terminal#Navigate("\<C-j>")
    tmap <expr><silent> <C-k> terminal#Navigate("\<C-k>")
    tmap <expr><silent> <C-l> terminal#Navigate("\<C-k>")
else
    set termwinkey=<C-v>
    tnoremap <C-h> <C-v>h
    tnoremap <C-j> <C-v>j
    tnoremap <C-k> <C-v>k
    tnoremap <C-l> <C-v>l
endif

" quickfix mapping
nnoremap <silent> <leader>co :call quickfix#ListToggle('copen')<CR>
nnoremap <silent> <leader>lo :call quickfix#ListToggle('lopen')<CR>
