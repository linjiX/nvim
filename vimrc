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

source ~/.vim/common/common.vim
source ~/.vim/plug.vim
source ~/.vim/common/colorscheme.vim

let g:solarized_termtrans = 1
colorscheme solarized
" colorscheme molokai

source ~/.vim/common/quickfix.vim
source ~/.vim/common/terminal.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- largefile --
let g:LargeFile = 10

"-- NERDTree & Tagbar --
source ~/.vim/config/nerdtree.vim

"-- NERDCommenter --
source ~/.vim/config/comment.vim

"-- fugitive --
source ~/.vim/config/git.vim

" -- CrtlSF --
source ~/.vim/config/ctrlsf.vim

" -- FZF --
source ~/.vim/config/fzf.vim

" -- LeaderF --
source ~/.vim/config/leaderf.vim

"-- AsyncRun --
source ~/.vim/config/asyncrun.vim

" -- unimpaired --
source ~/.vim/config/unimpaired.vim

" -- Airline --
source ~/.vim/config/airline.vim

" -- COC --
source ~/.vim/config/coc.vim

" -- ALE --
source ~/.vim/config/ale.vim

" -- vim-slime --
source ~/.vim/config/slime.vim

" -- python-mode --
source ~/.vim/config/pymode.vim

" -- vim-cpp-enhanced-highlight --
source ~/.vim/config/polyglot.vim

"-- FSwitch --
source ~/.vim/config/fswitch.vim

"-- vim-smooth-scroll --
source ~/.vim/config/smooth-scroll.vim

"-- vim-autoformat --
source ~/.vim/config/autoformat.vim

"-- vim-rooter --
let g:rooter_manual_only = 1

"-- markdown-preview --
source ~/.vim/config/markdown.vim

"-- startify --
source ~/.vim/config/startify.vim

"-- textobj --
source ~/.vim/config/textobj.vim

"-- BufKill --
source ~/.vim/config/bufkill.vim

"-- Gundo --
source ~/.vim/config/undo.vim

"-- vim-sneak --
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"-- vim-expand-region --
map <leader>= <Plug>(expand_region_expand)
map <leader>- <Plug>(expand_region_shrink)

"-- rainbow --
source ~/.vim/config/rainbow.vim

"-- vim-easy-align --
vmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"-- vim-better-whitespace --
nnoremap <silent> ]$ :NextTrailingWhitespace<CR>
nnoremap <silent> [$ :PrevTrailingWhitespace<CR>

"-- vim-interestinwords --
source ~/.vim/config/interestingwords.vim

source ~/.vim/config/star.vim

"-- vim-devicons --
let g:webdevicons_enable_nerdtree = 0

"-- xterm-color-table --
source ~/.vim/config/xterm-color-table.vim

"-- vim-peekaboo --
let g:peekaboo_window = "vertical botright 50new"
let g:peekaboo_delay = 1000

"-- vim-choosewin --
let g:choosewin_label = '123456789'
let g:choosewin_tablabel = 'ABCDEFGHIJKLMNOPQRTUVWYZ'

nmap <leader>W <Plug>(choosewin)
" let g:choosewin_overlay_enable = 1

"-- change-colorscheme --
nnoremap ]r :NextColorScheme<CR>
nnoremap [r :PreviousColorScheme<CR>

"-- quickr-preview --
let g:quickr_preview_keymaps = 0
let g:quickr_preview_position = 'right'
augroup myQuickFixPreview
    autocmd!
    autocmd FileType qf nmap <silent><buffer> p <Plug>(quickr_preview)
augroup END

"-- YankRing --
" nnoremap <silent> <leader>P :YRShow<CR>
" nnoremap <silent> <leader>p :YRGetElem 1<CR>
" nnoremap <silent> <leader>yc :YRClear<CR>
" let g:yankring_replace_n_pkey = ''
" let g:yankring_replace_n_nkey = ''
" let g:yankring_max_history = 20
" let g:yankring_history_dir = s:vim_cache
" augroup myYankRing
"     autocmd!
"     autocmd BufEnter \[YankRing\] cnoreabbrev <silent><buffer> q YRShow
" augroup END
" if has('nvim')
"     let g:yankring_clipboard_monitor = 0
" endif

"-- conflict-marker.vim --

"-- swapit --
source ~/.vim/config/swapit.vim

"-- vim-protodef --
source ~/.vim/config/protodef.vim

"-- echodoc.vim --
set noshowmode
set shortmess+=c
let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'floating'

"-- vim-visual-multi --
" let g:VM_maps = {}
" let g:VM_maps["Select l"] = '<C-Right>'
" let g:VM_maps["Select h"] = '<C-Left>'

"-- vim-which-key --
source ~/.vim/config/which-key.vim

"-- limelight --
nnoremap <F3> :Limelight!!<CR>
let g:limelight_conceal_ctermfg = '10'

"-- quickmenu --
source ~/.vim/config/quickmenu.vim
