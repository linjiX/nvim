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
if !has('nvim')
    set encoding=utf-8
endif
" set nocompatible
set nobackup
let mapleader="\<Space>"

filetype plugin indent on
syntax enable
syntax on

" source all configurations
source ~/.vim/vimrc.plug
let s:configs = split(glob('~/.vim/common/*.vim'))
if !exists('g:auto_installation')
    let s:configs += split(glob('~/.vim/config/*.vim'))
endif
for s:config in s:configs
    execute 'source '. s:config
endfor

set background=dark
set t_Co=256

silent! colorscheme solarized
" silent! colorscheme molokai

set number
set nowrap
set confirm
set cursorline
set cursorcolumn
set colorcolumn=100
set textwidth=0
set splitright
" set splitbelow

set list
set listchars=tab:>-
set hlsearch
set incsearch

set hidden
set autoread
set wildmenu
set wildmode=longest:full,full
set scrolloff=1
set history=30
set updatetime=10
set synmaxcol=300

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

set completeopt-=preview
set diffopt+=vertical
set path=.,/usr/include,/usr/local/include
set ttimeoutlen=25
if has('macunix')
    set backspace=2
    set clipboard^=unnamed
else
    set clipboard^=unnamedplus
endif

set foldmethod=syntax
set foldlevel=100
set foldnestmax=2
"set foldcolumn=2

" for echodoc
set noshowmode
set shortmess+=c

if has('nvim')
    set inccommand=nosplit
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175
else
    " Change cursor shape in different modes
    let &t_EI .= "\e[1 q" "EI = NORMAL mode (ELSE)
    let &t_SR .= "\e[3 q" "SR = REPLACE mode
    let &t_SI .= "\e[5 q" "SI = INSERT mode
    set guifont=Consolas-with-Yahei:h14
endif
