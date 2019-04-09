set nocompatible
set nobackup

if filereadable(expand("~/.vim/vimrc.plug"))
    source ~/.vim/vimrc.plug
    autocmd BufWritePost ~/.vim/vimrc.plug source ~/.vim/vimrc.plug
endif

filetype plugin indent on
syntax enable
syntax on

"-- colorscheme --
set background=dark
autocmd ColorScheme * hi Sneak cterm=bold,underline ctermfg=red
autocmd ColorScheme * hi link YcmErrorSection Error
autocmd ColorScheme * hi link YcmWarningSection Todo
" autocmd ColorScheme * hi link ExtraWhitespace LineNR
autocmd ColorScheme * hi link ExtraWhitespace Visual
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
" set listchars=tab:>-,trail:.
set listchars=tab:>-

set hlsearch
set incsearch

set autoindent
set smartindent
autocmd FileType c,cpp set cindent

set foldmethod=syntax
set foldlevel=100
set foldnestmax=2
"set foldcolumn=2

set history=30

set wildmenu
set hidden

set colorcolumn=100

set updatetime=100

"set autowrite
set autoread
set scrolloff=1

set diffopt+=vertical

set path=.,/usr/include,/usr/local/include,~/Document/lib

set completeopt-=preview

let mapleader="\<Space>"

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" nnoremap <leader>l :nohlsearch<CR>

packadd! matchit

autocmd BufNewFile,BufRead *.launch set filetype=xml
autocmd BufNewFile,BufRead *.urdf set filetype=xml
autocmd BufNewFile,BufRead *.BUILD set filetype=bzl
autocmd BufNewFile,BufRead WORKSPACE set filetype=bzl
autocmd BufNewFile,BufRead .arc* set filetype=json

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

autocmd FileType qf set bufhidden=delete
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>:lclose<CR>

" cnoreabbrev H vertical botright help
" cnoreabbrev T vertical botright terminal
nnoremap <leader>T :vertical botright terminal<CR>


"Close VIM when only quickfix window visable
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

"open help window vertical split
augroup vimrc_help
    autocmd!
    autocmd BufEnter * if &buftype == 'help' | wincmd L | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- vim-plug --
nnoremap <leader>pp :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pg :PlugUpgrade<CR>

"-- gutentags setting --
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_project_root = ['.root']
let g:gutentags_exclude_filetypes = ['bzl', 'vim', 'markdown', 'yaml', 'xml', 'json', 'lua', 'sh', 'dockerfile']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_auto_add_gtags_cscope = 1
let g:gutentags_ctags_extra_args = ['--c++-kinds=+plxcdefgmnstuv', '--c-kinds=+plxcdefgmnstuv', '--fields=+iaS', '--extra=+q']
let g:gutentags_file_list_command = {
                \ 'markers': {
                    \ '.git': 'git ls-files',
                    \ '.root': 'find -type f',
                    \ },
                \ }

" let g:gutentags_trace = 1
let g:gutentags_plus_nomap = 1

nnoremap <leader>g<Space> :GscopeFind 
nnoremap <silent> <leader>gs :GscopeFind s <C-r><C-w><CR>
nnoremap <silent> <leader>gg :GscopeFind g <C-r><C-w><CR>
nnoremap <silent> <leader>gc :GscopeFind c <C-r><C-w><CR>
nnoremap <silent> <leader>gt :GscopeFind t <C-r><C-w><CR>
nnoremap <silent> <leader>ge :GscopeFind e <C-r><C-w><CR>
nnoremap <silent> <leader>gf :GscopeFind f <C-r>=expand("<cfile>")<CR><CR>
nnoremap <silent> <leader>gi :GscopeFind i <C-r>=expand("<cfile>")<CR><CR>
nnoremap <silent> <leader>gd :GscopeFind d <C-r><C-w><CR>
nnoremap <silent> <leader>ga :GscopeFind a <C-r><C-w><CR>

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

"-- fugitve --
cnoreabbrev Gstatus vertical botright Gstatus

"-- GitGutter --
nnoremap <leader>gF :GitGutterFold<CR>
nmap <leader>gp <Plug>GitGutterPreviewHunk
nmap <leader>gS <Plug>GitGutterStageHunk
nmap <leader>gu <Plug>GitGutterUndoHunk
omap ig <Plug>GitGutterTextObjectInnerPending
omap ag <Plug>GitGutterTextObjectOuterPending
xmap ig <Plug>GitGutterTextObjectInnerVisual
xmap ag <Plug>GitGutterTextObjectOuterVisual
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

"-- CrtlP --
" let g:ctrlp_max_height = 13
" let g:ctrlp_extensions = ['funky']
" let g:ctrlp_funky_syntax_highlight = 1
" " let g:ctrlp_root_markers = ['.root']
" let g:ctrlp_by_filename = 1
" let g:ctrlp_working_path_mode = 'wra'
" " let g:ctrlp_show_hidden = 1
" if executable('ag')
    " set grepprg=ag\ --nogroup\ --nocolor
    " let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore-dir=".git" --ignore="*\.swp" -g ""'
    " let g:ctrlp_use_caching = 0
" endif

" -- CrtlSF --
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_position = "right"
let g:ctrlsf_default_root = 'project'
" let g:ctrlsf_extra_root_markers = ['.root']
let g:ctrlsf_winsize = '45%'
let g:ctrlsf_ignore_dir = ['bazel-*', 'build', 'devel', 'install']

nmap <leader>s<Space> <Plug>CtrlSFPrompt
vmap <leader>sC <Plug>CtrlSFVwordPath
vmap <leader>sc <Plug>CtrlSFVwordExec
nmap <leader>sC <Plug>CtrlSFCwordPath
nmap <leader>sc <Plug>CtrlSFCwordExec
nmap <leader>sS <Plug>CtrlSFCCwordPath
nmap <leader>ss <Plug>CtrlSFCCwordExec
nmap <leader>sP <Plug>CtrlSFPwordPath
nmap <leader>sp <Plug>CtrlSFPwordExec
nnoremap <leader>so :CtrlSFToggle<CR>

" -- FZF --
let g:fzf_layout = { 'down': '~30%' }
" Insert mode completion
imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x><c-x> <plug>(fzf-complete-path)
imap <c-x><c-z> <plug>(fzf-complete-file-ag)
imap <c-x><c-j> <plug>(fzf-complete-line)

nnoremap <leader>zz :Files<CR>
nnoremap <leader>zg :GFiles<CR>
nnoremap <leader>zG :GFiles?<CR>
nnoremap <leader>zb :Buffers<CR>
nnoremap <leader>zc :Colors<CR>
nnoremap <leader>za :Ag<CR>
nnoremap <leader>zr :Rg<CR>
nnoremap <leader>zl :BLines<CR>
nnoremap <leader>zL :Lines<CR>
nnoremap <leader>zt :BTags<CR>
nnoremap <leader>zT :Tags<CR>
nnoremap <leader>z<leader> :Maps<CR>
nnoremap <leader>z` :Marks<CR>
nnoremap <leader>zw :Windows<CR>
nnoremap <leader>zm :History<CR>
nnoremap <leader>z: :History:<CR>
nnoremap <leader>z/ :History/<CR>
nnoremap <leader>zs :Snippets<CR>
nnoremap <leader>zo :BCommits<CR>
nnoremap <leader>zO :Commits<CR>
nnoremap <leader>ze :Commands<CR>
nnoremap <leader>zh :Helptags<CR>
nnoremap <leader>zf :Filetypes<CR>

" -- LeaderF --
let g:Lf_WindowHeight = 0.3
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_WorkingDirectoryMode = 'ac'
let g:Lf_ReverseOrder = 1
let g:Lf_DefaultMode = 'NameOnly'

let g:Lf_ShortcutF = '<C-p>'
let g:Lf_ShortcutB = '<leader>fb'
nnoremap <leader>ff :LeaderfFile<CR>
nnoremap <leader>fB :LeaderfBufferAll<CR>
nnoremap <leader>fm :LeaderfMru<CR>
nnoremap <leader>fM :LeaderfMruCwd<CR>
nnoremap <leader>ft :LeaderfBufTag<CR>
nnoremap <leader>fT :LeaderfBufTagAll<CR>
nnoremap <leader>fu :LeaderfFunction<CR>
nnoremap <leader>fU :LeaderfFunctionAll<CR>
nnoremap <leader>fl :LeaderfLine<CR>
nnoremap <leader>fL :LeaderfLineAll<CR>
nnoremap <leader>f: :LeaderfHistoryCmd<CR>
nnoremap <leader>f/ :LeaderfHistorySearch<CR>
nnoremap <leader>fs :LeaderfSelf<CR>
nnoremap <leader>fh :LeaderfHelp<CR>
nnoremap <leader>fc :LeaderfColorscheme<CR>
nnoremap <leader>fr :LeaderfRgInteractive<CR>
nnoremap <leader>fR :LeaderfRgRecall<CR>

" -- Ack --
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif
let g:ackhighlight = 1
let g:ack_use_cword_for_empty_search = 1
cnoreabbrev Ack Ack!
nnoremap <leader>* :Ack! -w <C-r><C-w> %<CR>
nnoremap <leader>g* :Ack! <C-r><C-w> %<CR>
nnoremap <leader># :Ack! -w <C-r><C-w><CR>
nnoremap <leader>g# :Ack! <C-r><C-w><CR>

function! VWordCmd(precmd, postcmd)
    let temp = @s
    norm! gv"sy
    let vword = substitute(@s, '\n', '\\n', 'g')
    let @s = temp
    let cmd = a:precmd .' "'. vword .': '. a:postcmd
    return cmd
endfunction

vnoremap <leader>* :<C-u>execute VWordCmd('Ack! -w', '%')<CR>
vnoremap <leader>g* :<C-u>execute VWordCmd('Ack!', '%')<CR>
vnoremap <leader># :<C-u>execute VWordCmd('Ack! -w', '')<CR>
vnoremap <leader>g# :<C-u>execute VWordCmd('Ack!', '')<CR>

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
nnoremap <leader>h :FSHere<CR>

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
let g:formatdef_my_custom_bzl = "'buildifier'"
let g:formatters_bzl = ['my_custom_bzl']
let g:autoformat_verbosemode = 1

nnoremap <leader>a :Autoformat<CR>

"-- vim-rooter --
let g:rooter_manual_only = 1

"-- startify --
nnoremap <leader>S :Startify<CR>
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

"-- BufKill --
let g:BufKillCreateMappings = 0

function! BufferDo(command_str)
    if ((expand('%') =~# 'NERD_tree' || expand('%') =~# 'Tagbar') && winnr('$') > 1)
        exe "normal! \<C-w>\l"
    endif
    exe 'normal! ' . a:command_str . "\<CR>"
endfunction

nnoremap <silent> <leader>o :call BufferDo(':BB')<CR>
nnoremap <silent> <leader>i :call BufferDo(':BF')<CR>
nnoremap <silent> <leader>` :call BufferDo(':BA')<CR>
nnoremap <silent> <leader>u :call BufferDo(':BUNDO')<CR>

nnoremap <silent> + :call BufferDo(':bn')<CR>
nnoremap <silent> _ :call BufferDo(':bp')<CR>
vnoremap <silent> + :<C-u>call BufferDo(':bn')<CR>
vnoremap <silent> _ :<C-u>call BufferDo(':bp')<CR>
nnoremap <silent> <leader>qq :call BufferDo(':BW')<CR>
nnoremap <silent> <leader>qd :call BufferDo(':BD')<CR>
nnoremap <silent> <leader>qu :call BufferDo(':BUN')<CR>
nnoremap <silent> <leader>qc :cclose<CR>:lclose<CR>

"-- Gundo --
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
nnoremap <leader>G :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_width = 60
let g:gundo_close_on_revert = 1

"-- vim-sneak --
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"-- vim-expand-region --
map <leader>= <Plug>(expand_region_expand)
map <leader>- <Plug>(expand_region_shrink)

"-- rainbow --
let g:rainbow_active = 1
nnoremap <leader>r :RainbowToggle<CR>
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['166', '034', '164', '178', '104', '045'],
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

"-- vim-easy-aline --
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"-- vim-better-whitespace --
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>
" let g:better_whitespace_ctermcolor='23'

"-- vim-interestinwords --
nnoremap <silent> <leader>k :call InterestingWords('n')<CR>
" nmap <leader>k <Plug>InterestingWords
vmap <leader>k <Plug>InterestingWords
" nmap <leader>K <Plug>InterestingWordsClear
nmap n <Plug>InterestingWordsForeward
nmap N <Plug>InterestingWordsBackward

nnoremap <silent> <leader>L :set hlsearch<CR>
nnoremap <silent> <BS> :call UncolorAllWords()<CR> :nohlsearch<CR>
let g:interestingWordsTermColors = ['039', '141', '047', '014', '207', '221']

"-- vim-cool --
let g:loaded_cool = 0
let g:CoolTotalMatches = 1

"-- vim-devicons --
let g:webdevicons_enable_nerdtree = 1

"-- xterm-color-table --
let g:XtermColorTableDefaultOpen = 'vertical botright vsplit'

"-- vim-highlight-cursor-words --
let g:HiCursorWords_delay = 0
let g:HiCursorWords_linkStyle='CursorLine'

"-- vim-peekaboo --
let g:peekaboo_window = "vertical botright 50new"
let g:peekaboo_delay = 1000

"-- vim-choosewin --
nmap <leader>W <Plug>(choosewin)
" let g:choosewin_overlay_enable = 1

"-- vim-parenmatch --
let g:loaded_matchparen = 1

"-- conflict-marker.vim --
let g:conflict_marker_enable_mappings = 0
nmap ]C <Plug>(conflict-marker-next-hunk)
nmap [C <Plug>(conflict-marker-prev-hunk)
nmap ct <Plug>(conflict-marker-themselves)
nmap co <Plug>(conflict-marker-ourselves)
nmap cn <Plug>(conflict-marker-none)
nmap cb <Plug>(conflict-marker-both)

"-- cpp_cppcheck.vim --
let g:cpp_cppcheck_options = "--language=c++ --enable=all --platform=unix64 --suppress=unusedFunction --suppress=unusedStructMember"

"-- vim-visual-multi --
" let g:VM_maps = {}
" let g:VM_maps["Select l"] = '<C-Right>'
" let g:VM_maps["Select h"] = '<C-Left>'

"-- vim-which-key --
nnoremap <F8> :WhichKey ''<CR>
vnoremap <F8> :WhichKeyVisual ''<CR>
nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>
let g:which_key_map = {
            \ '`' :"BufKillAlt",
            \ 'i' :"BufKillForward",
            \ 'o' :"BufKillBack",
            \ 'u' :"BufKillUndo",
            \}
let g:which_key_map.c = {'name':"+prefix NERDCommenter"}
let g:which_key_map.g = {'name':"+prefix Gscope && GitGutter"}
let g:which_key_map.q = {
            \ 'name': "+prefix BufKillBw",
            \ 'q': "BufKillBw",
            \ 'd': "BufKillBd",
            \ 'u': "BufKillBun",
            \ }
let g:which_key_map.s = {'name':"+prefix CtrlSF"}
let g:which_key_map.f = {'name':"+prefix LeaderF"}
let g:which_key_map.z = {'name':"+prefix fzf"}

call which_key#register('<Space>', "g:which_key_map")

"-- limelight --
nnoremap <F7> :Limelight!!<CR>
let g:limelight_conceal_ctermfg = '10'

"-- quickmenu --
nnoremap <silent><F12> :call quickmenu#toggle(0)<CR>
let g:quickmenu_options = "HL"
let g:quickmenu_padding_right = 25

call g:quickmenu#append("Startify", "Startify", "")

call g:quickmenu#append("# Mouse", "")
call g:quickmenu#append("Enable Mouse <F2>", "set mouse=a", "")
call g:quickmenu#append("Disable Mouse <F3>", "set mouse=", "")

call g:quickmenu#append("# Other Toggle", "")
call g:quickmenu#append("Turn CopyMode %{&number? 'on':'off'} <F4>", "call CopyModeToggle()", "")
call g:quickmenu#append("Turn Spell %{&spell? 'off':'on'} <F5>", "set spell!", "")
call g:quickmenu#append("Turn Paste %{&paste? 'off':'on'} <F6>", "set paste!", "")

call g:quickmenu#append("# Interesting", "")
call g:quickmenu#append("Limelight Toggle <F7>", "Limelight", "")
call g:quickmenu#append("WhichKey <F8>", "WhichKey ''", "")

nnoremap <F2> :set mouse=a<CR>
nnoremap <F3> :set mouse=<CR>
nnoremap <F4> :call CopyModeToggle()<CR>
set pastetoggle=<F5>
nnoremap <F6> :set spell!<CR>

function CopyModeToggle()
    set nu!
    exec "IndentLinesToggle"
    exec "GitGutterSignsToggle"
    exec "SignatureToggleSigns"
endfunction
