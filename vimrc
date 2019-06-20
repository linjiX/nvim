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

if filereadable(expand("~/.vim/vimrc.plug"))
    source ~/.vim/vimrc.plug
    autocmd BufWritePost ~/.vim/vimrc.plug source ~/.vim/vimrc.plug
endif

filetype plugin indent on
syntax enable
syntax on

"-- colorscheme --
set background=dark

augroup myColorScheme
    autocmd!
    autocmd ColorScheme * call <SID>AutoCmdColorScheme()
augroup END
function s:AutoCmdColorScheme() abort
    highlight Sneak cterm=bold,underline ctermfg=red

    highlight UserError cterm=bold,underline ctermfg=9
    highlight UserWarning cterm=bold,underline ctermfg=13
    highlight UserErrorSign cterm=bold ctermfg=9
    highlight UserWarningSign cterm=bold ctermfg=13

    highlight link YcmErrorSection UserError
    highlight link YcmErrorSign UserErrorSign
    highlight link YcmWarningSection UserWarning
    highlight link YcmWarningSign UserWarningSign

    highlight link ALEError UserErrorSign
    highlight link ALEWarning UserWarningSign

    highlight link ExtraWhighlighttespace Visual
endfunction

let g:solarized_termtrans = 1
colorscheme solarized

" for molokai colorscheme
" colorscheme molokai
" highlight! link CursorLine CursorColumn
" highlight Visual ctermbg=238

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

set updatetime=100

set autoread
set scrolloff=1

set diffopt+=vertical

set path=.,/usr/include,/usr/local/include

set completeopt-=preview

" set splitbelow

let mapleader="\<Space>"

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

packadd! matchit

augroup myFileType
    autocmd!
    autocmd BufNewFile,BufRead *.launch set filetype=xml
    autocmd BufNewFile,BufRead *.urdf set filetype=xml
    autocmd BufNewFile,BufRead *.BUILD set filetype=bzl
    autocmd BufNewFile,BufRead WORKSPACE set filetype=bzl
    autocmd BufNewFile,BufRead .arc* set filetype=json
augroup END

augroup myCommonConfig
    autocmd!
    autocmd FileType c,cpp set cindent
    " Disable automatic comment insertion
    autocmd BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    autocmd BufRead * nmap Y y$
augroup END

" Enable the configuration once the vimrc is written
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

augroup myCursor
    autocmd!
    " Change cursor shape in different modes
    autocmd VimEnter,InsertLeave *
                \ silent execute '!echo -ne "\e[1 q"' |
                \ redraw!
    autocmd InsertEnter,InsertChange *
                \ if v:insertmode == 'i' |
                \     silent execute '!echo -ne "\e[5 q"' |
                \     redraw! |
                \ elseif v:insertmode == 'r' |
                \     silent execute '!echo -ne "\e[3 q"' |
                \     redraw! |
                \ endif
    autocmd VimLeave *
                \ silent execute '!echo -ne "\e[ q"' |
                \ redraw!

    " Locate cursor to the last position
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal g`\"" |
                \ endif
augroup END

"-- clipboard --"
set clipboard^=unnamedplus

"--QuickFix--"
augroup myQuickFix
    autocmd!
    autocmd FileType qf call <SID>AutoCmdQuickFix()
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow

    " Close VIM when only quickfix window visable
    autocmd WinEnter *
                \ if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" |
                \     q |
                \ endif
augroup END

function s:AutoCmdQuickFix() abort
    set bufhidden=delete
    nnoremap <silent><buffer> <CR> :pclose<CR><CR>:cclose<CR>:lclose<CR>
    nnoremap <silent><buffer> q :call PLCclose()<CR>
    nnoremap <silent><buffer> <leader>q :call PLCclose()<CR>
endfunction

" QuickFix window toggle
nnoremap <silent> <leader>co :call QListToggle()<CR>
nnoremap <silent> <leader>lo :call LListToggle()<CR>

function PLCclose() abort
    pclose
    lclose
    cclose
endfunction

function LListToggle() abort
    let window_count_before = winnr('$')
    call PLCclose()
    if winnr('$') == window_count_before
        lopen
    endif
endfunction

function QListToggle() abort
    let window_count_before = winnr('$')
    call PLCclose()
    if winnr('$') == window_count_before
        copen
    endif
endfunction

" function s:BufferCount() abort
    " return len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))
" endfunction

" autocmd FileType list nnoremap <buffer> <leader>q <ESC>
" autocmd FileType list nnoremap <buffer> q <ESC>

nnoremap <C-t> :vertical botright terminal<CR>

augroup myHelp
    autocmd!
    " open help window vertical split
    autocmd BufEnter *
                \ if &buftype == 'help' |
                \     wincmd L |
                \     nnoremap <silent><buffer> <leader>q :helpclose<CR> |
                \     nnoremap <silent><buffer> q :helpclose<CR> |
                \ endif
augroup END

augroup myLeaderQ
    autocmd!
    autocmd BufEnter *
                \ if &buftype == 'nofile' |
                \     nnoremap <silent><buffer> <leader>q :q<CR> |
                \     nnoremap <silent><buffer> q :q<CR> |
                \ endif
augroup END

let s:vim_tags = expand('~/.cache/tags')
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- vim-plug --
nnoremap <leader>vv :PlugInstall<CR>
nnoremap <leader>vc :PlugClean<CR>
nnoremap <leader>vu :PlugUpdate<CR>
nnoremap <leader>vg :PlugUpgrade<CR>

"-- gutentags setting --
" let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_modules = ['gtags_cscope']
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_project_root = ['.root']
let g:gutentags_exclude_filetypes = [
            \ '', 'gitrebase', 'conf', 'diff', 'Dockerfile', 'text', 'proto',
            \ 'tags', 'python', 'bzl', 'vim', 'markdown', 'yaml', 'xml', 'json', 'lua', 'sh'
            \ ]
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_auto_add_gtags_cscope = 1
" let g:gutentags_ctags_extra_args = [
            " \ '--c++-kinds=+plxcdefgmnstuv',
            " \ '--c-kinds=+plxcdefgmnstuv',
            " \ '--fields=+iaS',
            " \ '--extra=+q'
            " \ ]
let g:gutentags_file_list_command = {
            \ 'markers': {
            \     '.git': 'git ls-files',
            \     '.root': 'find -type f',
            \     },
            \ }

" let g:gutentags_trace = 1
let g:gutentags_plus_nomap = 1

nnoremap <leader>g<Space> :GscopeFind 
nnoremap <silent> <leader>gs :GscopeFind s <C-r><C-w><CR>
nnoremap <silent> <leader>gg :GscopeFind g <C-r><C-w><CR>
nnoremap <silent> <leader>gc :GscopeFind c <C-r><C-w><CR>
nnoremap <silent> <leader>gt :GscopeFind t <C-r><C-w><CR>
nnoremap <silent> <leader>ge :GscopeFind e <C-r><C-w><CR>
nnoremap <silent> <leader>gf :GscopeFind f <C-r>=expand("<cfile>:t")<CR><CR>
nnoremap <silent> <leader>gi :GscopeFind i <C-r>=expand("<cfile>:t")<CR><CR>
nnoremap <silent> <leader>gI :GscopeFind i <C-r>=fnameescape(expand('%:t'))<CR><CR>
nnoremap <silent> <leader>gd :GscopeFind d <C-r><C-w><CR>
nnoremap <silent> <leader>ga :GscopeFind a <C-r><C-w><CR>

"-- NERDTree & Tagbar --
let s:width = 30
let g:NERDTreeWinSize = s:width
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['bazel-', '\~$']
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
let g:tagbar_width = s:width
let g:tagbar_indent = 0
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_left = 1

nnoremap <leader>F :NERDTreeFind<CR>
nnoremap <leader>w :ToggleNERDTreeAndTagbar<CR>

"-- NERDCommenter --
let g:NERDSpaceDelims = 1

"-- fugitive --
cnoreabbrev Gstatus vertical botright Gstatus

"-- GitGutter --
nnoremap <leader>gr :GitGutter<CR>
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

" -- CrtlSF --
if executable('ag')
    let g:ctrlsf_ackprg = 'ag'
endif
let g:ctrlsf_position = 'right'
let g:ctrlsf_default_root = 'project+fw'
" let g:ctrlsf_extra_root_markers = ['.root']
let g:ctrlsf_winsize = '45%'
let g:ctrlsf_ignore_dir = ['bazel-*', 'build', 'devel', 'install']
let g:ctrlsf_auto_focus = {
            \ "at" : "done",
            \ "duration_less_than": 1000
            \ }

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

augroup myCtrlSF
    autocmd!
    autocmd FileType ctrlsf nnoremap <silent><buffer> <leader>q :CtrlSFClose<CR>
augroup END

" -- FZF --
let g:fzf_layout = { 'down': '~30%' }
" Insert mode completion
imap <C-x><C-w> <plug>(fzf-complete-word)
imap <C-x><C-x> <plug>(fzf-complete-path)
imap <C-x><C-z> <plug>(fzf-complete-file-ag)
imap <C-x><C-j> <plug>(fzf-complete-line)

nnoremap <silent> <leader>zz :Files<CR>
nnoremap <silent> <leader>zg :GFiles<CR>
nnoremap <silent> <leader>zG :GFiles?<CR>
nnoremap <silent> <leader>zb :Buffers<CR>
nnoremap <silent> <leader>zc :Colors<CR>
nnoremap <silent> <leader>za :Ag<CR>
nnoremap <silent> <leader>zr :Rg<CR>
nnoremap <silent> <leader>zl :BLines<CR>
nnoremap <silent> <leader>zL :Lines<CR>
nnoremap <silent> <leader>zt :BTags<CR>
" nnoremap <silent> <leader>zT :Tags<CR>
nnoremap <silent> <leader>z<leader> :Maps<CR>
nnoremap <silent> <leader>z` :Marks<CR>
nnoremap <silent> <leader>zw :Windows<CR>
nnoremap <silent> <leader>zm :History<CR>
nnoremap <silent> <leader>z: :History:<CR>
nnoremap <silent> <leader>z/ :History/<CR>
nnoremap <silent> <leader>zs :Snippets<CR>
nnoremap <silent> <leader>zo :BCommits<CR>
nnoremap <silent> <leader>zO :Commits<CR>
nnoremap <silent> <leader>ze :Commands<CR>
nnoremap <silent> <leader>zh :Helptags<CR>
nnoremap <silent> <leader>zf :Filetypes<CR>

" -- LeaderF --
let g:Lf_WindowHeight = 0.3
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ReverseOrder = 1
let g:Lf_DefaultMode = 'NameOnly'

let g:Lf_ShortcutF = '<C-p>'
let g:Lf_ShortcutB = '<leader>fb'
nnoremap <silent> <leader>ff :Leaderf file<CR>
nnoremap <silent> <leader>fB :Leaderf buffer --all<CR>
nnoremap <silent> <leader>fm :Leaderf mru --cwd<CR>
nnoremap <silent> <leader>fM :Leaderf mru<CR>
nnoremap <silent> <leader>ft :Leaderf bufTag<CR>
nnoremap <silent> <leader>fT :Leaderf bufTag --all<CR>
nnoremap <silent> <leader>fu :Leaderf function<CR>
nnoremap <silent> <leader>fU :Leaderf function --all<CR>
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>fL :Leaderf line --all<CR>
nnoremap <silent> <leader>f: :Leaderf cmdHistory<CR>
nnoremap <silent> <leader>f/ :Leaderf searchHistory<CR>
nnoremap <silent> <leader>fs :Leaderf self<CR>
nnoremap <silent> <leader>fh :Leaderf help<CR>
nnoremap <silent> <leader>fc :Leaderf colorscheme<CR>
nnoremap <silent> <leader>fr :Leaderf rg<CR>
nnoremap <silent> <leader>fR :Leaderf rg --recall<CR>

"-- AsyncRun --
let g:asyncrun_rootmarks = ['.git']

if executable('ag')
    set grepprg=ag\ --vimgrep
    let g:asyncagprg = 'ag --vimgrep -Q'
else
    let g:asyncagprg = 'grep -H -n'
endif

function AsyncAg(cmd, args)
    let l:args = empty(a:args) ? expand("<cword>") .' %' : escape(a:args, '#%')
    execute a:cmd .' '. g:asyncagprg .' '. l:args
endfunction
command -bang -nargs=* -complete=file AsyncAg call AsyncAg('AsyncRun<bang>', <q-args>)

nnoremap <leader>* :AsyncAg! -w <C-r><C-w> %<CR>
nnoremap <leader>g* :AsyncAg! <C-r><C-w> %<CR>
nnoremap <leader># :AsyncAg! -w <C-r><C-w> <root><CR>
nnoremap <leader>g# :AsyncAg! <C-r><C-w> <root><CR>

vnoremap <leader>* :<C-u>execute VWordCmd('AsyncAg! -w', '%')<CR>
vnoremap <leader>g* :<C-u>execute VWordCmd('AsyncAg!', '%')<CR>
vnoremap <leader># :<C-u>execute VWordCmd('AsyncAg! -w', '<root>')<CR>
vnoremap <leader>g# :<C-u>execute VWordCmd('AsyncAg!', '<root>')<CR>

function VWordCmd(precmd, postcmd)
    let temp = @s
    norm! gv"sy
    let vword = escape(@s, '#%')
    " let vword = @s
    let @s = temp
    let cmd = a:precmd ." '". vword ."' ". a:postcmd
    return cmd
endfunction

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

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.dirty='*'

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
" let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1

let g:ycm_use_clangd = 0
" let g:ycm_clangd_binary_path = exepath('clangd-8')
" let g:ycm_clangd_uses_ycmd_caching = 0

nnoremap <silent> <leader>j :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>t :YcmCompleter GetType<CR>
nnoremap <silent> <leader>d :YcmDiags<CR>
nnoremap <silent> <leader>x :YcmCompleter FixIt<CR>

" -- ALE --
let g:ale_disable_lsp = 1
let g:ale_linters = {'cpp': ['CppCheck']}
let g:ale_linters_explicit = 1
let g:ale_echo_msg_format = '[%linter%][%severity%] %s'
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✗'
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0

call ale#linter#Define('cpp', {
\   'name': 'CppCheck',
\   'output_stream': 'both',
\   'executable': 'cppcheck',
\   'command': '%e -q --language=c++ --enable=all --platform=unix64 --suppress=unusedFunction --suppress=unusedStructMember %t',
\   'callback': 'ale#handlers#cppcheck#HandleCppCheckFormat',
\})

function ALEDiags()
    let g:ale_set_quickfix = 1
    ALELint
    copen
    autocmd ale WinLeave *
                \ if &buftype == 'quickfix' |
                \     let g:ale_set_quickfix = 0 |
                \     autocmd! ale WinLeave |
                \ endif
endfunction

augroup myALE
    autocmd!
    autocmd BufRead * ALELint
    autocmd FileType cpp nnoremap <silent><buffer> <leader>D :call ALEDiags()<CR>
augroup END

nmap [k <Plug>(ale_previous)
nmap ]k <Plug>(ale_next)
nmap [K <Plug>(ale_first)
nmap ]K <Plug>(ale_last)

" -- UltiSnips --
let g:UltiSnipsExpandTrigger = '<C-k>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" -- vim-cpp-enhanced-highlight --
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_concepts_highlight = 1

"-- FSwitch --
nnoremap <leader>h :FSHere<CR>

augroup myFSwitch
    autocmd!
    autocmd BufEnter *.h let b:fswitchdst = 'cc,cpp,c'
    autocmd BufEnter *.h let b:fswitchlocs = '.,reg:/include/src/,reg:/include.*/src/,../src,reg:/include/source/,reg:/include.*/source/,../source'
    autocmd BufEnter *.c* let b:fswitchdst = 'h'
    autocmd BufEnter *.c* let b:fswitchlocs = '.,reg:/src/include/,reg:|src|include/**|,../include,reg:/source/include/,reg:|source|include/**|'
augroup END

"-- vim-smooth-scroll --
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 5, 2)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 5, 2)<CR>
nnoremap <silent> <C-b> :call smooth_scroll#up(&scroll*2, 5, 4)<CR>
nnoremap <silent> <C-f> :call smooth_scroll#down(&scroll*2, 5, 4)<CR>

"-- vim-autoformat --
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

let g:formatdef_my_custom_cpp = "'clang-format-6.0 -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=file'"
let g:formatters_cpp = ['my_custom_cpp']
let g:formatdef_my_custom_bzl = "'buildifier'"
let g:formatters_bzl = ['my_custom_bzl']
let g:autoformat_verbosemode = 0

nnoremap <leader>a :Autoformat<CR>
xnoremap <leader>a :Autoformat<CR>

"-- vim-rooter --
let g:rooter_manual_only = 1

"-- startify --
nnoremap <leader>S :Startify<CR>
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [
            \ {'v': '~/.vim/vimrc'},
            \ {'p': '~/.vim/vimrc.plug'},
            \ {'y': '~/.vim/ycm_extra_conf.py'},
            \ {'b': '~/.bashrc'},
            \ ]
let g:startify_skiplist = [
            \ $HOME .'/.vim',
            \ $HOME .'/.bashrc',
            \ ]

"-- textobj --
let g:textobj_comment_no_default_key_mappings = 1
xmap am <Plug>(textobj-comment-a)
omap am <Plug>(textobj-comment-a)
xmap im <Plug>(textobj-comment-i)
omap im <Plug>(textobj-comment-a)
xmap aM <Plug>(textobj-comment-big-a)
omap aM <Plug>(textobj-comment-big-a)

let g:vim_textobj_parameter_mapping = 'a'

"-- BufKill --
let g:BufKillCreateMappings = 0

function BufferDo(command_str)
    if ((expand('%') =~# 'NERD_tree' || expand('%') =~# 'Tagbar') && winnr('$') > 1)
        exe "normal! \<C-w>\l"
    endif
    exe 'silent normal! ' . a:command_str . "\<CR>"
endfunction

nnoremap <silent> <leader>o :call BufferDo(':BB')<CR>
nnoremap <silent> <leader>i :call BufferDo(':BF')<CR>
nnoremap <silent> <leader>` :call BufferDo(':BA')<CR>
nnoremap <silent> <leader>u :call BufferDo(':BUNDO')<CR>

nnoremap <silent> + :call BufferDo(':bn')<CR>
nnoremap <silent> _ :call BufferDo(':bp')<CR>
vnoremap <silent> + :<C-u>call BufferDo(':bn')<CR>
vnoremap <silent> _ :<C-u>call BufferDo(':bp')<CR>
nnoremap <silent> <leader>q :BW<CR>
nnoremap <silent> <leader>Q :BD<CR>

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
nnoremap <leader>R :RainbowToggle<CR>
nnoremap <F2> :RainbowToggle<CR>
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

"-- vim-interestinwords --
nnoremap <silent> <leader>k :call InterestingWords('n')<CR>
vmap <leader>k <Plug>InterestingWords

nnoremap <silent> <BS> :call UncolorAllWords()<CR>:nohlsearch<CR>
let g:interestingWordsTermColors = ['002', '004', '005', '006', '013', '009']

"-- vim-searchindex --
function IsSearch() abort
    let win_view = winsaveview()
    let origin_pos = getpos(".")
    call search(@/, "c")
    if origin_pos == getpos(".")
        let is_search = 1
    else
        let is_search = 0
    endif
    call winrestview(win_view)
    return is_search
endfunction

function s:UserPrintMatches() abort
    if IsSearch() == 1
        SearchIndex
    endif
endfunction
command -bar UserSearchIndex call <SID>UserPrintMatches()

nnoremap <silent> n :silent call WordNavigation(1)<CR>:UserSearchIndex<CR>
            \:if IsSearch() == 1<CR> set hlsearch<CR> endif<CR>
nnoremap <silent> N :silent call WordNavigation(0)<CR>:UserSearchIndex<CR>
            \:if IsSearch() == 1<CR> set hlsearch<CR> endif<CR>
nmap <silent> * *:UserSearchIndex<CR>
nmap <silent> # #:UserSearchIndex<CR>

"-- vim-devicons --
let g:webdevicons_enable_nerdtree = 0

"-- xterm-color-table --
let g:XtermColorTableDefaultOpen = 'vertical botright vsplit'
augroup myXtermColorTable
    autocmd!
    autocmd BufEnter __XtermColorTable__ set bufhidden=delete
augroup END

"-- vim-highlight-cursor-words --
let g:HiCursorWords_delay = 50
let g:HiCursorWords_linkStyle='CursorLine'

"-- vim-peekaboo --
let g:peekaboo_window = "vertical botright 50new"
let g:peekaboo_delay = 1000

"-- vim-choosewin --
nmap <leader>W <Plug>(choosewin)
" let g:choosewin_overlay_enable = 1

"-- vim-parenmatch --
let g:loaded_matchparen = 1

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
nnoremap <silent> <leader>P :YRShow<CR>
nnoremap <silent> <leader>p :YRGetElem 1<CR>
nnoremap <silent> <leader>yc :YRClear<CR>
let g:yankring_replace_n_pkey = ''
let g:yankring_replace_n_nkey = ''
let g:yankring_max_history = 20
let g:yankring_history_dir = s:vim_tags
augroup myYankRing
    autocmd!
    autocmd BufEnter \[YankRing\] cnoreabbrev <silent><buffer> q YRShow
augroup END

"-- conflict-marker.vim --
let g:conflict_marker_enable_mappings = 0
nmap ]C <Plug>(conflict-marker-next-hunk)
nmap [C <Plug>(conflict-marker-prev-hunk)
nmap ct <Plug>(conflict-marker-themselves)
nmap co <Plug>(conflict-marker-ourselves)
nmap cn <Plug>(conflict-marker-none)
nmap cb <Plug>(conflict-marker-both)

"-- swapit --
augroup mySwapit
    autocmd!
    autocmd BufRead * call <SID>AutoCmdSwapList()
    autocmd FileType gitrebase call <SID>AutoCmdGitrebaseSwapList()
augroup END

function s:AutoCmdGitrebaseSwapList() abort
    ClearSwapList
    SwapList GitRebase pick squash reword edit fixup exec drop
endfunction
function s:AutoCmdSwapList() abort
    vnoremap <C-a> <C-a>
    vnoremap <C-x> <C-x>
    SwapList TRUE/FALSE TRUE FALSE
    SwapList YES/NO YES NO
endfunction

nmap <Plug>SwapItFallbackIncrement :call FallbackIncrement()<CR>
nmap <Plug>SwapItFallbackDecrement :call FallbackDecrement()<CR>

function FallbackIncrement()
    nnoremap <Plug>SwapItFallbackIncrement <C-a>
    call <SID>LocateNumber()
    execute "normal \<Plug>SwapIncrement"
    nnoremap <Plug>SwapItFallbackIncrement :call FallbackIncrement()<CR>
endfunction

function FallbackDecrement()
    nnoremap <Plug>SwapItFallbackDecrement <C-x>
    call <SID>LocateNumber()
    execute "normal \<Plug>SwapDecrement"
    nnoremap <Plug>SwapItFallbackDecrement :call FallbackDecrement()<CR>
endfunction

let g:true_false_pattern = '\v<[Tt]rue>|<[Ff]alse>|<TRUE>|<FALSE>'
let g:oct_number_pattern = '\d*\zs\d'
let g:hex_number_pattern = '0(x|X)\x*\zs\x'
let g:bin_number_pattern = '0(b|B)[01]*\zs[01]'
let g:full_pattern = join([g:true_false_pattern, g:hex_number_pattern, g:bin_number_pattern, g:oct_number_pattern], '|')

function s:LocateNumber() abort
    let l:pos = getpos(".")
    let l:flag = search(g:true_false_pattern, "cb", line("."))
    if l:flag != 0
        if l:pos[2] < col(".")  + strlen(expand("<cword>"))
            call setpos(".", l:pos)
            return
        endif
        call setpos(".", l:pos)
    endif
    call search(g:full_pattern, "c", line("."))
endfunction

"-- vim-visual-multi --
" let g:VM_maps = {}
" let g:VM_maps["Select l"] = '<C-Right>'
" let g:VM_maps["Select h"] = '<C-Left>'

"-- vim-which-key --
nnoremap <F4> :WhichKey ''<CR>
vnoremap <F4> :WhichKeyVisual ''<CR>
nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>
let g:which_key_map = {
            \ '`' :"BufKillAlt",
            \ 'i' :"BufKillForward",
            \ 'o' :"BufKillBack",
            \ 'q' :"BufKillBw",
            \ 'Q' :"BufKillBd",
            \ 'u' :"BufKillUndo",
            \}
let g:which_key_map.c = {'name':"+prefix NERDCommenter"}
let g:which_key_map.g = {'name':"+prefix Gscope && GitGutter"}
let g:which_key_map.s = {'name':"+prefix CtrlSF"}
let g:which_key_map.f = {'name':"+prefix LeaderF"}
let g:which_key_map.z = {'name':"+prefix fzf"}

call which_key#register('<Space>', "g:which_key_map")

"-- limelight --
nnoremap <F3> :Limelight!!<CR>
let g:limelight_conceal_ctermfg = '10'

"-- quickmenu --
nnoremap <silent><F12> :call quickmenu#toggle(0)<CR>
augroup myQuickMenu
    autocmd!
    autocmd FileType quickmenu nnoremap <silent><buffer> <leader>q :call quickmenu#toggle(0)<CR>
augroup END
let g:quickmenu_options = "HL"
let g:quickmenu_padding_right = 25

call g:quickmenu#append("Startify", "Startify", "")

call g:quickmenu#append("# Interesting", "")
call g:quickmenu#append("Rainbow Toggle <F2>", "RainbowToggle", "")
call g:quickmenu#append("Limelight Toggle <F3>", "Limelight!!", "")
call g:quickmenu#append("WhichKey <F4>", "WhichKey ''", "")

call g:quickmenu#append("# System Toggle", "")
call g:quickmenu#append("Turn Mouse %{&mouse == '' ? 'on':'off'} <F5>", "call MouseToggle()", "")
call g:quickmenu#append("Turn Sidebar %{&number? 'on':'off'} <F6>", "call SidebarToggle()", "")
call g:quickmenu#append("Turn Spell %{&spell? 'off':'on'} <F7>", "set spell!", "")
call g:quickmenu#append("Turn Paste %{&paste? 'off':'on'} <F8>", "set paste!", "")

nnoremap <silent> <F5> :call MouseToggle()<CR>
nnoremap <silent> <F6> :call SidebarToggle()<CR>
nnoremap <F7> :set spell!<CR>
set pastetoggle=<F8>

function MouseToggle()
    if &mouse == ''
        set mouse=a
        echo "Mouse On"
    else
        set mouse=
        echo "Mouse Off"
    endif
endfunction

function SidebarToggle()
    set number!
    if &number
        set signcolumn=auto
        echo "Sidebar On"
    else
        set signcolumn=no
        echo "Sidebar Off"
    endif
endfunction
