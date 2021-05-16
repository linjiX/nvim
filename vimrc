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
if has('nvim')
    finish
endif

filetype plugin indent on
syntax on

let $MY_DATA_PATH = $HOME .'/.local/share/vim'

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set backupdir=.,$MY_DATA_PATH/backup
set belloff=all
set complete-=i
set cscopeverbose
set directory=$MY_DATA_PATH/swap//
set display=lastline  " lastline,msgsep
set encoding=utf-8
set fillchars=vert:│,fold:·
set formatoptions=tcqj
set nofsync
set history=10000
set hlsearch
set incsearch
set langnoremap
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
set nrformats=bin,hex
set ruler
set sessionoptions-=options
set shortmess+=F
set shortmess-=S
set showcmd
set sidescroll=1
set smarttab
set tabpagemax=50
set tags=./tags;,tags
set ttimeoutlen=50
set ttyfast
set undodir=$MY_DATA_PATH/undo
set viminfo+=!
set viminfofile=$MY_DATA_PATH/viminfo
set wildmenu
set wildoptions=tagfile  "pum,tagfile

if !isdirectory(&directory)
    call mkdir(&directory, 'p')
endif

execute "set <M-a>=\ea"

set runtimepath-=$HOME/.vim
set runtimepath-=$HOME/.vim/after

let $VIM_HOME = $HOME .'/.config/nvim'
set runtimepath^=$VIM_HOME
source $VIM_HOME/init.vim

scriptencoding utf-8
