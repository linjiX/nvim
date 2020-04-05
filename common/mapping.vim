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

if has_key(g:plugs, 'vim-tmux-navigator')
    " Plug 'christoomey/vim-tmux-navigator'
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <C-\> :TmuxNavigatePrevious<CR>
    nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
    nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
    nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
    nmap <silent><expr> <C-j>
                \ coc#util#has_float() ? '<Plug>(coc-float-jump)'
                \                      : ':TmuxNavigateDown<CR>'
else
    nnoremap <C-h> <C-w>h
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    nmap <silent><expr> <C-j>
                \ coc#util#has_float() ? '<Plug>(coc-float-jump)'
                \                      : "\<C-w>j"
endif

" normal mode mapping
nnoremap Y y$
nnoremap <C-p> "0p
xnoremap <C-p> "0p

nnoremap <silent> <C-w>m :tabnew %<CR>
nnoremap <silent> <C-w><C-m> :tabnew %<CR>
xnoremap <silent> <C-m> :sort<CR>

" command mapping
cnoreabbrev <expr><silent> q utility#Quit('q')
cnoreabbrev <expr><silent> wq utility#Quit('wq')
cnoreabbrev <silent> w!! w !sudo tee % >/dev/null

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

cnoremap <C-o> <C-f>
cnoremap <C-a> <Home>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>

" insert mapping
inoremap <C-x><C-a> <C-a>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" quickfix mapping
nnoremap <silent> <leader>co :call quickfix#ListToggle('copen')<CR>
nnoremap <silent> <leader>lo :call quickfix#ListToggle('lopen')<CR>
