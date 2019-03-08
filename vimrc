set nocompatible
set nobackup

if filereadable(expand("~/.vim/vimrc.plug"))
    source ~/.vim/vimrc.plug
    autocmd BufWritePost ~/.vim/vimrc.plug source ~/.vim/vimrc.plug
endif

filetype plugin indent on
syntax enable
syntax on

set background=dark
colorscheme solarized
set cursorline
set cursorcolumn
set number
set nowrap

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set list
set listchars=tab:>-,trail:.

set hlsearch
set incsearch

set autoindent
set smartindent
set cindent

set foldmethod=syntax
set foldlevel=100
set foldnestmax=2
"set foldcolumn=2

set history=30

set wildmenu
set hidden

set cc=100

set updatetime=100

"set autowrite
set autoread
set scrolloff=1

set path=.,/usr/include,/usr/local/include,~/Document/lib

set completeopt-=preview

let mapleader="\<space>"

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>l :nohlsearch<CR>

set pastetoggle=<F12>

packadd! matchit

autocmd BufNewFile,BufRead *.launch set filetype=xml
autocmd BufNewFile,BufRead *.urdf set filetype=xml
autocmd BufNewFile,BufRead *.BUILD set filetype=bzl
autocmd BufNewFile,BufRead WORKSPACE set filetype=bzl

"Enable the configuration once the vimrc is written
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

"Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Change cursor shape in different modes
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' |
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

"Locate cursor to the last position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif


"--QuickFix--"
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>:lclose<CR>

cnoreabbrev H vertical botright help
cnoreabbrev T vertical botright terminal

"Close VIM when only quickfix window visable
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- gutentags setting --
let g:gutentags_modules = ['ctags', 'gtags_cscope']
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_project_root = ['.git, .root']
let g:gutentags_exclude_filetypes = ['bzl']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_auto_add_gtags_cscope = 1
let g:gutentags_ctags_extra_args = ['--c++-kinds=+plxcdefgmnstuv', '--c-kinds=+plxcdefgmnstuv', '--fields=+iaS', '--extra=+q']
let g:gutentags_file_list_command = {
    \ 'markers': {
        \ '.git': 'git ls-files',
        \ '.root': 'find -type f',
        \ },
    \ }

let g:gutentags_plus_nomap = 1

nnoremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
nnoremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
nnoremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
nnoremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
nnoremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
nnoremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
nnoremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
nnoremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
nnoremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

"-- NERDTree & Tagbar --
let g:NERDTreeWinSize = 30
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['bazel-', '\~$']
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
let g:tagbar_width = 30
let g:tagbar_indent = 0
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_left = 1

nmap <leader>F :NERDTreeFind<CR>
nmap <leader>w :ToggleNERDTreeAndTagbar<CR>

"-- NERDCommenter --
let g:NERDSpaceDelims = 1

"-- CrtlP --
let g:ctrlp_max_height = 10
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_root_markers = ['.root']
let g:ctrlp_by_filename = 1
" let g:ctrlp_show_hidden = 1
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore-dir=".git" --ignore="*\.swp" -g ""'
    let g:ctrlp_use_caching = 0
endif

" -- CrtlSF --
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_position = "right"
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_extra_root_markers = ['.root']
let g:ctrlsf_winsize = '45%'
let g:ctrlsf_ignore_dir = ['bazel-*', 'build', 'devel', 'install']

nmap <leader>f <Plug>CtrlSFPrompt
vmap <leader>fC <Plug>CtrlSFVwordPath
vmap <leader>fc <Plug>CtrlSFVwordExec
nmap <leader>fC <Plug>CtrlSFCwordPath
nmap <leader>fc <Plug>CtrlSFCwordExec
nmap <leader>fF <Plug>CtrlSFCCwordPath
nmap <leader>ff <Plug>CtrlSFCCwordExec
nmap <leader>fP <Plug>CtrlSFPwordPath
nmap <leader>fp <Plug>CtrlSFPwordExec
nnoremap <leader>fo :CtrlSFToggle<CR>

" -- FZF --
let g:fzf_layout = { 'down': '~30%' }

" -- Ack --
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif
let g:ackhighlight = 1
let g:ack_use_cword_for_empty_search = 1
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" -- Airline --
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#gutentags#enabled = 1

let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" -- YouCompleteMe --
"let g:ycm_global_ycm_extra_conf = '~/.vim/plug/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-j>'
let g:ycm_max_num_candidates = 10
let g:ycm_max_num_identifier_candidates = 6
let g:ycm_error_symbol = 'E'
let g:ycm_warning_symbol = 'W'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_goto_buffer_command = 'new-tab'

nnoremap <leader>j :YcmCompleter GoTo<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>d :YcmDiags<CR>
nnoremap <leader>x :YcmCompleter FixIt<CR>


" -- UltiSnips --
let g:UltiSnipsExpandTrigger = '<C-l>'

" -- vim-cpp-enhanced-highlight --
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_concepts_highlight = 1


"-- FSwitch --
nnoremap <leader>s :FSHere<CR>

autocmd BufEnter *.h let b:fswitchdst  = 'cpp,cc,c'
autocmd BufEnter *.h let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,../src,reg:/include/source/,reg:/include.*/source/,../source'
autocmd BufEnter *.cc let b:fswitchdst  = 'h'
autocmd BufEnter *.cc let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include,reg:/source/include/,reg:|source|include/**|'

"-- vim-smooth-scroll --
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 2)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 2)<CR>
nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 4)<CR>
nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 4)<CR>


"-- vim-autoformat --
let g:formatdef_my_custom_cpp = "'clang-format-6.0 -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=file'"
let g:formatters_cpp = ['my_custom_cpp']
let g:autoformat_verbosemode = 1

"-- vim-rooter --
let g:rooter_manual_only = 1

"-- startify --
nmap <leader>S :Startify<CR>
let g:startify_bookmarks = [
    \ {'v': '~/.vim/vimrc'},
    \ {'p': '~/.vim/vimrc.plug'},
    \ {'y': '~/.vim/ycm_extra_conf.py'},
    \ {'b': '~/.bashrc'},
    \ ]

"-- textobj --
let g:textobj_comment_no_default_key_mappings = 1
xmap am <Plug>(textobj-comment-a)
omap am <Plug>(textobj-comment-a)
xmap im <Plug>(textobj-comment-i)
omap im <Plug>(textobj-comment-a)
xmap aM <Plug>(textobj-comment-big-a)
omap aM <Plug>(textobj-comment-big-a)

"-- bufkill --
nnoremap <leader>o :BB<CR>
nnoremap <leader>i :BF<CR>

nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>q :BW<CR>

"-- Gundo --
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
nnoremap <leader>G :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_width = 60
let g:gundo_close_on_revert = 1

"-- clever-f.vim --
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

"-- rainbow --
let g:rainbow_active = 0
nmap <leader>r :RainbowToggle<CR>
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['darkyellow', 'darkcyan', 'darkmagenta', 'darkgreen', 'darkred'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

"-- Promptline --
"let g:promptline_preset = {
      "\'a'    : [ '\h' ],
      "\'b'    : [ '\u' ],
      "\'c'    : [ '\w' ] }
