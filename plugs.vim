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

" COC plugins {{{
let g:coc_global_extensions = [
            \   'coc-word',
            \   'coc-highlight',
            \   'coc-snippets',
            \   'coc-json',
            \   'coc-pyright',
            \   'coc-vimlsp',
            \   'coc-translator',
            \   'coc-explorer',
            \   'coc-yank',
            \   'coc-yaml',
            \]
" \   'coc-xml',
" \   'coc-python',
if has('macunix')
    let g:coc_global_extensions += ['coc-imselect']
endif

" }}}

" vim-plug config {{{
let $MY_PLUG_VIM = $VIM_HOME .'/autoload/plug.vim'
if !filereadable($MY_PLUG_VIM)
    call setup#AutoInstallation()
endif

let g:plug_window = 'botright vertical new'

augroup myPlugs
    autocmd FileType vim-plug nmap <leader>q q
augroup END

nnoremap <silent> <leader>vv :PlugUpdate<CR>
nnoremap <silent> <leader>vi :PlugInstall<CR>
nnoremap <silent> <leader>vc :PlugClean<CR>
nnoremap <silent> <leader>vg :PlugUpgrade<CR>
nnoremap <silent> <leader>vd :PlugDiff<CR>
nnoremap <silent> <leader>vs :PlugStatus<CR>
" }}}

call plug#begin($VIM_HOME .'/plug')

" Feature {{{
Plug $VIM_HOME .'/feature/terminal'
if !exists('g:auto_installation')
    let $MY_LINTER_PATH = $VIM_HOME .'/feature/linter/config'

    Plug $VIM_HOME .'/feature/arc'
    Plug $VIM_HOME .'/feature/buffer'
    Plug $VIM_HOME .'/feature/fold'
    Plug $VIM_HOME .'/feature/large'
    Plug $VIM_HOME .'/feature/linter'
    Plug $VIM_HOME .'/feature/run'
endif
" }}}

" Help {{{
Plug 'yianwillis/vimcdoc', has('nvim') ? {'on': []} : {}
if has('macunix')
    Plug 'rizzatti/dash.vim', {'on': ['Dash', 'DashKeywords', '<Plug>Dash']}
endif
" }}}

" Menu {{{
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'linjiX/vim-defx-vista'
" Plug 'liuchengxu/vista.vim'
" Plug 'pseewald/nerdtree-tagbar-combined'
" Plug 'scrooloose/nerdtree'
" Plug 'simnalamburt/vim-mundo'
" Plug 'sjl/gundo.vim', {'on': ['GundoToggle', 'GundoShow']}
" Plug 'skywind3000/quickmenu.vim'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'kristijanhusak/defx-icons'
" Plug 'kristijanhusak/defx-git'
" if has('nvim')
"     Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}
" else
"     Plug 'Shougo/defx.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" endif
Plug 'liuchengxu/vim-which-key'
Plug 'preservim/tagbar', {'on': ['Tagbar', 'TagbarOpen', 'TagbarToggle']}
Plug 'mbbill/undotree', {'on': ['UndotreeToggle', 'UndotreeShow']}
Plug 'mhinz/vim-startify'
" }}}

" Colorscheme {{{
" Plug 'chxuan/change-colorscheme', {'on': ['NextColorScheme', 'PreviousColorScheme']}
" Plug 'flazz/vim-colorschemes'
" Plug 'rafi/awesome-vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'vim-scripts/ScrollColors', {'on': ['NEXTCOLOR', 'PREVCOLOR']}
" }}}

" Edit {{{
" Plug 'AndrewRadev/linediff.vim'
" Plug 'AndrewRadev/switch.vim'
" Plug 'jiangmiao/auto-pairs'
" Plug 'mg979/vim-visual-multi'
" Plug 'raimondi/delimitmate'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'vim-scripts/YankRing.vim'
" Plug 'xcodebuild/fcitx-vim-osx'
Plug 'dkarter/bullets.vim', {'for': ['markdown', 'gitcommit', 'text', 'log', 'conf', 'arcdiff']}
Plug 'junegunn/vim-peekaboo'
Plug 'kana/vim-niceblock'
Plug 'mjbrownie/swapit'
Plug 'svermeulen/vim-subversive', {'on': '<Plug>(Subversive'}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
if !has('macunix')
    Plug 'lilydjwg/fcitx.vim'
endif
" }}}

" Formatter {{{
" Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'chiel92/vim-autoformat', {'on': ['Autoformat', 'RemoveTrailingSpaces']}
Plug 'junegunn/vim-easy-align', {'on': [
            \   '<Plug>(EasyAlign)',
            \   '<Plug>(LiveEasyAlign)',
            \   'EasyAlign',
            \   'LiveEasyAlign'
            \]}
" }}}

" Display {{{
" Plug 'itchyny/vim-cursorword'
" Plug 'itchyny/vim-parenmatch'
" Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
" Plug 'lfv89/vim-interestingwords'
" Plug 'pboettch/vim-highlight-cursor-words'
Plug 'Yggdroot/indentLine'
Plug 'guns/xterm-color-table.vim', {'on': 'XtermColorTable'}
Plug 'linjiX/vim-keyword', {'on': '<Plug>(keyword-'}
Plug 'luochen1990/rainbow'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}

" Coding {{{
" Plug 'SirVer/ultisnips'
" Plug 'Valloric/YouCompleteMe'
" Plug 'jsfaint/gen_tags.vim'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" Plug 'scrooloose/nerdcommenter'
" Plug 'skywind3000/gutentags_plus'
" Plug 'szymonmaszke/vimpyter'
" Plug 'tpope/vim-commentary'
Plug 'Shougo/echodoc.vim'
Plug 'dense-analysis/ale'
Plug 'linjiX/vim-fswitch', {'on': 'FSHere'}
Plug 'derekwyatt/vim-protodef', {'for': ['c', 'cpp']}
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector', {'on': '<Plug>Vimspector'}
Plug 'tomtom/tcomment_vim', {'on': ['<Plug>TComment_', 'TComment']}
Plug 'tpope/vim-endwise'
" }}}

" Build & Run {{{
" Plug 'bazelbuild/vim-bazel'
" Plug 'google/vim-maktaba'
" Plug 'jalvesaq/vimcmdline'
" Plug 'rhysd/reply.vim'
Plug 'jpalardy/vim-slime', {'on': ['<Plug>Slime', 'SlimeSend', 'SlimeSend1']}
Plug 'skywind3000/asyncrun.vim', {'on': ['AsyncRun', 'AsyncStop']}
" }}}

" Git {{{
" Plug 'cohama/agit.vim', {'on': ['Agit', 'AgitFile']}
" Plug 'junegunn/gv.vim', {'on': 'GV'}
" Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
Plug 'rbong/vim-flog', {'on': ['Flog', 'Flogsplit']}
Plug 'rhysd/conflict-marker.vim'
Plug 'rhysd/git-messenger.vim', {'on': ['<Plug>(git-messenger)', 'GitMessenger']}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" }}}

" Searcher {{{
" Plug 'tacahiroy/ctrlp-funky'
" Plug 'vim-scripts/ctrlp.vim'
" Plug 'mileszs/ack.vim'
" Plug 'henrik/vim-indexed-search'
" Plug 'osyo-manga/vim-anzu'
" Plug 'romainl/vim-cool'
" Plug 'haya14busa/vim-asterisk'
" Plug 'nelstrom/vim-visual-star-search'
" if has('macunix')
"     Plug '/usr/local/opt/fzf'
" else
"     Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
" endif
" Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/LeaderF', {'do': './install.sh', 'on': 'Leaderf'}
Plug 'dyng/ctrlsf.vim', {'on': ['<Plug>CtrlSF', 'CtrlSF', 'CtrlSFToggle', 'CtrlSFOpen']}
Plug 'google/vim-searchindex', {'on': 'SearchIndex'}
Plug 'linjiX/LeaderF-git', {'on': 'Leaderf'}
Plug 'linjiX/vim-star'
" }}}

" Cursor Move {{{
" Plug 'rhysd/accelerated-jk'
" Plug 'terryma/vim-smooth-scroll'
" Plug 'yuttie/comfortable-motion.vim'
Plug 'andymass/vim-matchup'
Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-prefix)'}
Plug 'justinmk/vim-sneak', {'on': '<Plug>Sneak_'}
Plug 'kshenoy/vim-signature'
Plug 't9md/vim-choosewin', {'on': '<Plug>(choosewin)'}
Plug 'yonchu/accelerated-smooth-scroll', {'on': '<Plug>(ac-smooth-scroll-c-'}
" }}}

" Text Object {{{
" Plug 'gaving/vim-textobj-argument'
" Plug 'kana/vim-textobj-line'
" Plug 'lucapette/vim-textobj-underscore'
" Plug 'mattn/vim-textobj-url'
" Plug 'rhysd/vim-textobj-anyblock'
" Plug 'sgur/vim-textobj-parameter'
" Plug 'terryma/vim-expand-region', {'on': '<Plug>(expand_region_'}
Plug 'coderifous/textobj-word-column.vim'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'wellle/line-targets.vim'
Plug 'wellle/targets.vim'
" }}}

" Markdown {{{
" Plug 'plasticboy/vim-markdown'
" Plug 'suan/vim-instant-markdown'
Plug 'dhruvasagar/vim-table-mode', {'on': ['TableModeToggle', 'TableModeEnable']}
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()},
            \                         'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
" }}}

" Tmux {{{
" Plug 'edkolev/tmuxline.vim', {'on': 'Tmuxline'}
Plug 'christoomey/vim-tmux-navigator', {'on': [
            \   'TmuxNavigatePrevious',
            \   'TmuxNavigateUp',
            \   'TmuxNavigateDown',
            \   'TmuxNavigateLeft',
            \   'TmuxNavigateRight',
            \]}
" }}}

" Others {{{
" Plug 'qpkorr/vim-bufkill'
" Plug 'tpope/vim-sensible'
" Plug 'vim-scripts/LargeFile'
Plug 'Shougo/vinarise.vim', {'on': 'Vinarise'}
Plug 'airblade/vim-rooter' ", {'on': 'Rooter'}
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch', {'on': [
            \   'Delete',
            \   'Unlink',
            \   'Remove',
            \   'Move',
            \   'Rename',
            \   'Chmod',
            \   'Mkdir',
            \   'Cfind',
            \   'Lfind',
            \   'Clocate',
            \   'Llocate',
            \   'SudoEdit',
            \   'SudoWrite',
            \   'Wall',
            \   'W',
            \]}
" }}}

call plug#end()

" vim:foldmethod=marker
