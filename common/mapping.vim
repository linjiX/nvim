""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/nvim                                "
"     _  _          _  _ __  __    __             _                "
"    | |(_) _ __   (_)(_)\ \/ /   / /_ __ __   __(_) _ __ ___      "
"    | || || '_ \  | || | \  /   / /| '_ \\ \ / /| || '_ ` _ \     "
"    | || || | | | | || | /  \  / / | | | |\ V / | || | | | | |    "
"    |_||_||_| |_|_/ ||_|/_/\_\/_/  |_| |_| \_/  |_||_| |_| |_|    "
"                |__/                                              "
"                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
let s:tmux_navigator_cmd = {
            \   'h': ':TmuxNavigateLeft',
            \   'j': ':TmuxNavigateDown',
            \   'k': ':TmuxNavigateUp',
            \   'l': ':TmuxNavigateRight',
            \   'p': ':TmuxNavigatePrevious',
            \}

function NavigateCmd(direction) abort
    let l:cmd = s:tmux_navigator_cmd[a:direction]
    if !exists(l:cmd)
        let l:cmd = ':wincmd '. a:direction
    endif
    return l:cmd ."\<CR>"
endfunction

nnoremap <expr><silent> <C-\> NavigateCmd('p')
nnoremap <expr><silent> <C-h> NavigateCmd('h')
nnoremap <expr><silent> <C-l> NavigateCmd('l')
nnoremap <expr><silent> <C-k> NavigateCmd('k')
nmap <expr><silent> <C-j>
            \ coc#util#has_float() ? '<Plug>(coc-float-jump)'
            \                      : NavigateCmd('j')

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

cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<Up>"
cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<Down>"
cnoremap <C-o> <C-f>
cnoremap <C-a> <Home>
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
