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

nnoremap <silent> <C-w>m :tabnew %<CR>
nnoremap <silent> <C-w><C-m> :tabnew %<CR>
vnoremap <silent> <C-n> :sort<CR>

" command mapping
cnoreabbrev <expr><silent> q buffer#Quit(0)
cnoreabbrev <expr><silent> wq buffer#Quit(1)
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
if has('nvim')
    cnoreabbrev terminal botright vsplit term://bash
    nnoremap <silent> <C-p> :botright vsplit term://bash<CR>
    nnoremap <silent> <leader>ei :botright vsplit term://ipython3<CR>
    nnoremap <silent> <leader>eb :botright vsplit term://bpython<CR>
    nnoremap <silent> <leader>et :botright vsplit term://ptpython3<CR>
    nnoremap <silent> <leader>eh :botright vsplit term://htop<CR>
    tnoremap <silent> <ESC><ESC> <C-\><C-n>:set number<CR>

    function s:Navigate(cmd) abort
        let l:esc = "\<C-\>\<C-n>"
        let l:flag = ":let b:terminal_navigate = 1\<CR>"
        return l:esc . l:flag . a:cmd
    endfunction

    tmap <expr><silent> <C-h> <SID>Navigate("\<C-h>")
    tmap <expr><silent> <C-j> <SID>Navigate("\<C-j>")
    tmap <expr><silent> <C-k> <SID>Navigate("\<C-k>")
    tmap <expr><silent> <C-l> <SID>Navigate("\<C-k>")
else
    set termwinkey=<C-v>
    nnoremap <silent> <C-p> :vertical botright terminal<CR>
    nnoremap <silent> <leader>ei :vertical botright terminal ++close ipython3<CR>
    nnoremap <silent> <leader>eb :vertical botright terminal ++close bpython<CR>
    nnoremap <silent> <leader>et :vertical botright terminal ++close ptpython3<CR>
    nnoremap <silent> <leader>eh :vertical botright terminal ++close htop<CR>
    tnoremap <ESC><ESC> <C-\><C-n>
    tnoremap <C-h> <C-v>h
    tnoremap <C-j> <C-v>j
    tnoremap <C-k> <C-v>k
    tnoremap <C-l> <C-v>l
endif

" quickfix mapping
nnoremap <silent> <leader>co :call quickfix#ListToggle('copen')<CR>
nnoremap <silent> <leader>lo :call quickfix#ListToggle('lopen')<CR>
