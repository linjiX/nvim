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
    packadd! matchit
endif

let g:plug_window = 'botright vertical new'

nnoremap <leader>vv :PlugInstall<CR>
nnoremap <leader>vc :PlugClean<CR>
nnoremap <leader>vu :PlugUpdate<CR>
nnoremap <leader>vg :PlugUpgrade<CR>
nnoremap <leader>vd :PlugDiff<CR>
nnoremap <leader>vs :PlugStatus<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
    call setup#AutoInstallation()
endif

call plug#begin('~/.vim/plug')

"-- Help --
Plug 'yianwillis/vimcdoc'

"-- Menu --
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'skywind3000/quickmenu.vim'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'liuchengxu/vim-which-key'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree', {'on': ['UndotreeToggle', 'UndotreeShow']}
Plug 'mhinz/vim-startify'
Plug 'pseewald/nerdtree-tagbar-combined'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim', {'on': ['GundoToggle', 'GundoShow']}

"-- Colorscheme --
" Plug 'flazz/vim-colorschemes'
" Plug 'rafi/awesome-vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'chxuan/change-colorscheme'
Plug 'tomasr/molokai'

"-- Edit --
" Plug 'AndrewRadev/linediff.vim'
" Plug 'jiangmiao/auto-pairs'
" Plug 'mg979/vim-visual-multi'
" Plug 'raimondi/delimitmate'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'vim-scripts/YankRing.vim'
Plug 'Shougo/vinarise.vim', {'on': 'Vinarise'}
Plug 'junegunn/vim-peekaboo'
Plug 'mjbrownie/swapit'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" -- Formatter --
Plug 'chiel92/vim-autoformat', {'on': ['Autoformat', 'RemoveTrailingSpaces']}
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'

"-- Display --
" Plug 'itchyny/vim-cursorword'
" Plug 'itchyny/vim-parenmatch'
" Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
" Plug 'pboettch/vim-highlight-cursor-words'
Plug 'Yggdroot/indentLine'
Plug 'guns/xterm-color-table.vim', {'on': 'XtermColorTable'}
Plug 'lfv89/vim-interestingwords'
Plug 'luochen1990/rainbow'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"-- Coding --
" Plug 'jsfaint/gen_tags.vim'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'SirVer/ultisnips'
" Plug 'Valloric/YouCompleteMe'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Plug 'skywind3000/gutentags_plus'
" Plug 'tpope/vim-commentary'
Plug 'Shougo/echodoc.vim'
Plug 'derekwyatt/vim-fswitch', {'for': ['c', 'cpp']}
Plug 'derekwyatt/vim-protodef', {'for': ['c', 'cpp']}
Plug 'honza/vim-snippets'
" Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'w0rp/ale'

"-- python --
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" Plug 'jpalardy/vim-slime', {'for': ['python', 'sh', 'markdown']}
Plug 'jpalardy/vim-slime'
" Plug 'jalvesaq/vimcmdline'
" Plug 'rhysd/reply.vim'
" Plug 'szymonmaszke/vimpyter'

"-- Compile --
" Plug 'bazelbuild/vim-bazel'
" Plug 'google/vim-maktaba'

"-- Git --
" Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim', {'on': ['Agit', 'AgitFile']}
Plug 'junegunn/gv.vim', {'on': 'GV'}
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'

"-- Searcher --
" Plug 'tacahiroy/ctrlp-funky'
" Plug 'vim-scripts/ctrlp.vim'
" Plug 'mileszs/ack.vim'
" Plug 'henrik/vim-indexed-search'
" Plug 'osyo-manga/vim-anzu'
" Plug 'romainl/vim-cool'
" Plug 'haya14busa/vim-asterisk'
" Plug 'nelstrom/vim-visual-star-search'
Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
Plug 'dyng/ctrlsf.vim'
Plug 'google/vim-searchindex'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'linjiX/vim-star'

"-- Cursor Move --
" Plug 'rhysd/accelerated-jk'
" Plug 'yuttie/comfortable-motion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'kshenoy/vim-signature'
Plug 't9md/vim-choosewin'
Plug 'terryma/vim-smooth-scroll'

"-- Visual --
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-niceblock'

"-- Text Object --
" Plug 'gaving/vim-textobj-argument'
" Plug 'rhysd/vim-textobj-anyblock'
Plug 'coderifous/textobj-word-column.vim'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'lucapette/vim-textobj-underscore'
Plug 'mattn/vim-textobj-url'
Plug 'sgur/vim-textobj-parameter'

"-- Markdown --
" Plug 'plasticboy/vim-markdown'
" Plug 'suan/vim-instant-markdown'
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}

"-- QuickFix --
Plug 'ronakg/quickr-preview.vim'

"-- tmux --
Plug 'edkolev/tmuxline.vim', {'on': 'Tmuxline'}

"-- Others --
" Plug 'tpope/vim-sensible'
Plug 'airblade/vim-rooter', {'on': 'Rooter'}
Plug 'qpkorr/vim-bufkill'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/LargeFile'

call plug#end()
