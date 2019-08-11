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
source ~/.vim/common/autocmd.vim
source ~/.vim/common/colorscheme.vim
source ~/.vim/common/map.vim

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
