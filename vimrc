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

set nocompatible
set nobackup
let mapleader="\<Space>"

filetype plugin indent on
syntax enable
syntax on

source ~/.vim/plug.vim
source ~/.vim/common/common.vim
source ~/.vim/common/colorscheme.vim
source ~/.vim/common/quickfix.vim
source ~/.vim/common/terminal.vim

set background=dark
set t_Co=256

colorscheme solarized
" colorscheme molokai

set cursorline
set cursorcolumn
set number
set nowrap

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set list
set listchars=tab:>-

set hlsearch
set incsearch

set autoindent
set smartindent

set foldmethod=syntax
set foldlevel=100
set foldnestmax=2
"set foldcolumn=2

set history=30

set wildmenu
set hidden

set colorcolumn=100
set textwidth=100

set updatetime=10

set autoread
set scrolloff=1

set diffopt+=vertical

set path=.,/usr/include,/usr/local/include

set completeopt-=preview

set synmaxcol=300

set clipboard^=unnamedplus

" for echodoc
set noshowmode
set shortmess+=c

" set splitbelow

nnoremap Y y$
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
cnoremap w!! w !sudo tee % > /dev/null
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" cnoremap <C-Left> <S-Left>
" cnoremap <C-Right> <S-Right>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
