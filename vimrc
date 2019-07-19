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
set t_Co=256

augroup myColorScheme
    autocmd!
    autocmd ColorScheme * call <SID>AutoCmdColorScheme()
    autocmd ColorScheme solarized call <SID>AutoCmdSolarzed()
    autocmd ColorScheme molokai call <SID>AutoCmdMolokai()
augroup END
function s:AutoCmdColorScheme() abort
    highlight Sneak cterm=bold,underline ctermfg=red

    highlight UserError cterm=bold,underline ctermfg=9
    highlight UserWarning cterm=bold,underline ctermfg=13
    highlight UserInfo cterm=bold,underline ctermfg=12
    highlight UserErrorSign cterm=bold ctermfg=9
    highlight UserWarningSign cterm=bold ctermfg=13
    highlight UserInfoSign cterm=bold ctermfg=12

    highlight link CocErrorSign UserErrorSign
    highlight link CocWarningSign UserWarningSign
    highlight link CocInfoSign UserInfoSign
    highlight link CocHintSign UserInfoSign
    highlight link CocErrorHighlight UserError
    highlight link CocWarningHighlight UserWarning
    highlight link CocInfoHighlight UserInfo
    highlight link CocHintHighlight UserInfo

    highlight link CocHighlightText CursorLine

    highlight link ALEErrorSign UserErrorSign
    highlight link ALEWarningSign UserWarningSign
    highlight link ALEInfoSign UserInfoSign

    highlight link ALEError Normal
    highlight link ALEWarning Normal
    highlight link ALEInfo Normal

    highlight link ExtraWhitespace Visual
endfunction
function s:AutoCmdSolarzed() abort
    highlight UserFloating ctermbg=232
    highlight link CocFloating UserFloating
    highlight link EchoDocFloat UserFloating
endfunction
function s:AutoCmdMolokai() abort
    highlight Visual ctermbg=238
    highlight! link CursorLine CursorColumn
    highlight link UserFloating Visual
    highlight link CocFloating UserFloating
    highlight link EchoDocFloat UserFloating
endfunction

let g:solarized_termtrans = 1
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

set updatetime=10

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

if !has('nvim')
    packadd! matchit
endif

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
    autocmd BufRead * nmap Y y$
    autocmd FileType c,cpp set cindent
    " Disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=cro
    " Close VIM when only no listed buffer window visable
    autocmd WinEnter *
                \ if winnr('$') == 1 &&
                \    getbufvar(winbufnr(winnr()), "&buflisted") == 0 &&
                \    getbufvar(winbufnr(winnr()), "&filetype") != 'startify'|
                \     q |
                \ endif
augroup END

" Enable the configuration once the vimrc is written
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Change cursor shape in different modes
let &t_EI .= "\e[1 q" "EI = NORMAL mode (ELSE)
let &t_SR .= "\e[3 q" "SR = REPLACE mode
let &t_SI .= "\e[5 q" "SI = INSERT mode

if has('nvim')
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175
endif

augroup myCursor
    " Locate cursor to the last position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit' |
                \     execute "normal g`\"" |
                \ endif
augroup END

"-- clipboard --"
set clipboard^=unnamedplus

"--QuickFix--"
augroup myQuickFix
    autocmd!
    autocmd FileType qf call <SID>AutoCmdQuickFix()
    autocmd QuickFixCmdPost [^l]* nested belowright cwindow
    autocmd QuickFixCmdPost    l* nested belowright lwindow
augroup END

function s:AutoCmdQuickFix() abort
    set bufhidden=delete
    silent! set nobuflisted
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
        belowright lopen
    endif
endfunction

function QListToggle() abort
    let window_count_before = winnr('$')
    call PLCclose()
    if winnr('$') == window_count_before
        belowright copen
    endif
endfunction

" terminal
if has('nvim')
    cnoreabbrev terminal botright vsplit term://bash
    nnoremap <silent> <C-t> :botright vsplit term://bash<CR>
    tmap <silent> <ESC> <C-\><C-n>:set number<CR>
    tmap <C-h> <ESC><C-w>h
    tmap <C-j> <ESC><C-w>j
    tmap <C-k> <ESC><C-w>k
    tmap <C-l> <ESC><C-w>l
else
    nnoremap <silent> <C-t> :vertical botright terminal<CR>
    tnoremap <ESC><ESC> <C-\><C-n>
    tnoremap <C-h> <C-w>h
    tnoremap <C-j> <C-w>j
    tnoremap <C-k> <C-w>k
    tnoremap <C-l> <C-w>l
    tnoremap <C-w>n <Nop>
endif

augroup myTerminal
    autocmd!
    if has('nvim')
        autocmd TermOpen * call <SID>AutoCmdTerminal()
    else
        autocmd TerminalOpen * call <SID>AutoCmdTerminal()
    endif
augroup END

function s:AutoCmdTerminal() abort
    set bufhidden=wipe
    set nobuflisted
    " set nomodifiable
    nnoremap <silent><buffer> <leader>q :q!<CR>
    nnoremap <silent><buffer> q :q!<CR>
    cnoreabbrev <buffer> q q!
    if has('nvim')
        nnoremap <silent><buffer> i :set nonumber<CR>i
    endif
endfunction

augroup myBufType
    autocmd!
    autocmd BufEnter * call <SID>AutoCmdBufType()
augroup END
function s:AutoCmdBufType() abort
    if &buftype == 'nofile'
        if expand("%:t") == "__Gundo__"
            nnoremap <silent><buffer> <leader>q :GundoHide<CR>
        else
            nnoremap <silent><buffer> <leader>q :q<CR>
            nnoremap <silent><buffer> q :q<CR>
        endif
    elseif &buftype == 'help'
        " open help window vertical split
        " set bufhidden=delete
        wincmd L
        nnoremap <silent><buffer> <leader>q :helpclose<CR>
        nnoremap <silent><buffer> q :helpclose<CR>
    elseif &buftype == 'terminal' && has('nvim')
        normal i
    endif
    if &previewwindow == 1
        set nobuflisted
    endif
endfunction

function BufferDo(command_str)
    if (&buflisted == 0 && winnr('$') > 1)
        let l:win = filter(range(1, winnr('$')), 'getbufvar(winbufnr(v:val), "&buflisted") == 1')
        if len(l:win) >= 1
            execute l:win[0] .'wincmd w'
        endif
    endif
    execute a:command_str
endfunction

let s:vim_cache = expand('~/.LfCache')
if !isdirectory(s:vim_cache)
    silent! call mkdir(s:vim_cache, 'p')
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- vim-plug --
let g:plug_window = 'botright vertical new'
nnoremap <leader>vv :PlugInstall<CR>
nnoremap <leader>vc :PlugClean<CR>
nnoremap <leader>vu :PlugUpdate<CR>
nnoremap <leader>vg :PlugUpgrade<CR>
nnoremap <leader>vd :PlugDiff<CR>
nnoremap <leader>vs :PlugStatus<CR>

"-- largefile --
let g:LargeFile = 10

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
let g:NERDDefaultAlign = 'left'
let g:NERDUsePlaceHolders = 0
let g:NERDCommenterMappings = 0

let g:NERDCustomDelimiters = { 'python': { 'left': '#', 'leftAlt': '', 'rightAlt': '' }}

map <leader>c<Space> <Plug>NERDCommenterComment
map <leader>cc <Plug>NERDCommenterToggle
map <leader>cm <Plug>NERDCommenterMinimal
map <leader>ci <Plug>NERDCommenterInvert
map <leader>cs <Plug>NERDCommenterSexy
map <leader>cy <Plug>NERDCommenterYank
map <leader>c$ <Plug>NERDCommenterToEOL
map <leader>cA <Plug>NERDCommenterAppend
map <leader>ca <Plug>NERDCommenterAltDelims
map <leader>cl <Plug>NERDCommenterAlignLeft
map <leader>cr <Plug>NERDCommenterAlignBoth
map <leader>cu <Plug>NERDCommenterUncomment

"-- fugitive --
cnoreabbrev Gstatus vertical botright Gstatus
augroup myFugitive
    autocmd FileType fugitive set nobuflisted
augroup END


"-- GitGutter --
nnoremap <leader>gR :GitGutter<CR>
nnoremap <leader>gf :GitGutterFold<CR>
nmap <leader>gp <Plug>GitGutterPreviewHunk
nmap <leader>ga <Plug>GitGutterStageHunk
nmap <leader>gu <Plug>GitGutterUndoHunk
omap ig <Plug>GitGutterTextObjectInnerPending
omap ag <Plug>GitGutterTextObjectOuterPending
xmap ig <Plug>GitGutterTextObjectInnerVisual
xmap ag <Plug>GitGutterTextObjectOuterVisual

" -- CrtlSF --
if executable('rg')
    let g:ctrlsf_ackprg = 'rg'
elseif executable('ag')
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
let g:fzf_layout = {'down': '~30%'}
" Insert mode completion
imap <C-x><C-w> <plug>(fzf-complete-word)
imap <C-x><C-x> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-line)
if executable('ag')
    imap <C-x><C-z> <plug>(fzf-complete-file-ag)
else
    imap <C-x><C-z> <plug>(fzf-complete-file)
endif

nnoremap <silent> <leader>zz :call BufferDo('Files')<CR>
nnoremap <silent> <leader>zb :call BufferDo('Buffers')<CR>
nnoremap <silent> <leader>zg :call BufferDo('GFiles')<CR>
nnoremap <silent> <leader>zG :call BufferDo('GFiles?')<CR>
nnoremap <silent> <leader>zo :call BufferDo('BCommits')<CR>
nnoremap <silent> <leader>zO :call BufferDo('Commits')<CR>
nnoremap <silent> <leader>za :call BufferDo('Ag')<CR>
nnoremap <silent> <leader>zr :call BufferDo('Rg')<CR>
nnoremap <silent> <leader>zt :call BufferDo('BTags')<CR>
" nnoremap <silent> <leader>zT :call BufferDo('Tags')<CR>
nnoremap <silent> <leader>z` :call BufferDo('Marks')<CR>
nnoremap <silent> <leader>zm :call BufferDo('History')<CR>
nnoremap <silent> <leader>zc :Colors<CR>
nnoremap <silent> <leader>zl :BLines<CR>
nnoremap <silent> <leader>zL :Lines<CR>
nnoremap <silent> <leader>z<leader> :Maps<CR>
nnoremap <silent> <leader>zw :Windows<CR>
nnoremap <silent> <leader>z: :History:<CR>
nnoremap <silent> <leader>z/ :History/<CR>
nnoremap <silent> <leader>zs :Snippets<CR>
nnoremap <silent> <leader>ze :Commands<CR>
nnoremap <silent> <leader>zh :Helptags<CR>
nnoremap <silent> <leader>zf :Filetypes<CR>

" -- LeaderF --
let g:Lf_WindowHeight = 0.3
let g:Lf_StlSeparator = {'left': '', 'right': ''}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ReverseOrder = 1
let g:Lf_DefaultMode = 'NameOnly'
" let g:Lf_RememberLastSearch = 1

if executable('gtags')
    let g:Lf_GtagsAutoGenerate = 1
else
    let g:Lf_GtagsAutoGenerate = 0
endif
let g:Lf_GtagsSource = 2
let g:Lf_GtagsfilesCmd = {'.git': 'git ls-files -c -o --exclude-standard'}
let g:Lf_GtagsSkipUnreadable = 1
let g:Lf_GtagsSkipSymlink = 'a'
let g:Lf_Gtagslabel = "native-pygments"

let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''
nnoremap <silent> <C-p> :call BufferDo('Leaderf file')<CR>
nnoremap <silent> <leader>ff :call BufferDo('Leaderf file')<CR>
nnoremap <silent> <leader>fb :call BufferDo('Leaderf buffer')<CR>
nnoremap <silent> <leader>fB :call BufferDo('Leaderf buffer --all')<CR>
nnoremap <silent> <leader>fm :call BufferDo('Leaderf mru --cwd')<CR>
nnoremap <silent> <leader>fM :call BufferDo('Leaderf mru')<CR>
nnoremap <silent> <leader>ft :call BufferDo('Leaderf bufTag')<CR>
nnoremap <silent> <leader>fT :call BufferDo('Leaderf bufTag --all')<CR>
nnoremap <silent> <leader>fu :call BufferDo('Leaderf function')<CR>
nnoremap <silent> <leader>fU :call BufferDo('Leaderf function --all')<CR>
nnoremap <silent> <leader>fg :call BufferDo('Leaderf gtags')<CR>
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>fL :Leaderf line --all<CR>
nnoremap <silent> <leader>f: :Leaderf cmdHistory<CR>
nnoremap <silent> <leader>f/ :Leaderf searchHistory<CR>
nnoremap <silent> <leader>fs :Leaderf self<CR>
nnoremap <silent> <leader>fh :Leaderf help<CR>
nnoremap <silent> <leader>fc :Leaderf colorscheme<CR>
nnoremap <silent> <leader>fr :Leaderf rg<CR>
nnoremap <silent> <leader>fR :Leaderf rg --recall<CR>

nnoremap <silent> <leader>gg :Leaderf! gtags -d <C-r><C-w><CR>
nnoremap <silent> <leader>gr :Leaderf! gtags -r <C-r><C-w><CR>
nnoremap <silent> <leader>gs :Leaderf! gtags -s <C-r><C-w><CR>
nnoremap <silent> <leader>gt :Leaderf! gtags -g <C-r><C-w><CR>
nnoremap <silent> <leader>gi :Leaderf! gtags -g <C-r>=expand("<cfile>:t")<CR><CR>
nnoremap <silent> <leader>gI :Leaderf! gtags -g <C-r>=fnameescape(expand("%:t"))<CR><CR>

"-- AsyncRun --
let g:asyncrun_rootmarks = ['.git']

if executable('rg')
    set grepprg=rg\ --vimgrep
    let g:asyncagprg = 'rg --vimgrep -F -U'
elseif executable('ag')
" if executable('ag')
    set grepprg=ag\ --vimgrep
    let g:asyncagprg = 'ag --vimgrep -Q'
else
    let g:asyncagprg = 'grep -H -n'
endif

function s:AsyncGrep(cmd, args)
    let l:args = empty(a:args) ? expand("<cword>") .' %' : escape(a:args, '#%')
    execute join([a:cmd, g:asyncagprg, l:args], ' ')
endfunction
command -bang -nargs=* -complete=file AsyncGrep call <SID>AsyncGrep('AsyncRun<bang>', <q-args>)

function AsyncStar(is_visual, is_global, is_g) abort
    let l:pattern = '"'. escape(a:is_visual ? star#Vword() : star#Cword(), '$\`"#%') .'"'
    call setpos('.', s:pos)
    let l:whole = a:is_g ? '' : '-w'
    let l:file = a:is_global ? '<root>' : '%'
    execute join(['AsyncGrep!', l:whole, l:pattern, l:file], ' ')
endfunction

function s:AsyncStarCommand(is_visual, is_global, is_g) abort
    let s:pos = getpos('.')
    return ':call AsyncStar('. a:is_visual .', '. a:is_global .', '. a:is_g .")\<CR>"
endfunction

nnoremap <expr><silent> <leader>* <SID>AsyncStarCommand(0, 0, 0)
nnoremap <expr><silent> <leader>g* <SID>AsyncStarCommand(0, 0, 1)
nnoremap <expr><silent> <leader># <SID>AsyncStarCommand(0, 1, 0)
nnoremap <expr><silent> <leader>g* <SID>AsyncStarCommand(0, 1, 1)

vnoremap <expr><silent> <leader>* <SID>AsyncStarCommand(1, 0, 1)
vnoremap <expr><silent> <leader>g* <SID>AsyncStarCommand(1, 0, 1)
vnoremap <expr><silent> <leader># <SID>AsyncStarCommand(1, 1, 1)
vnoremap <expr><silent> <leader>g# <SID>AsyncStarCommand(1, 1, 1)

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

" -- COC --
function! s:CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-j>
            \ pumvisible() ? "\<C-n>"
            \              : coc#refresh()
inoremap <silent><expr> <C-k>
            \ pumvisible() ? "\<C-p>"
            \              : "\<C-k>"
imap <silent><expr> <TAB>
            \ pumvisible() ? coc#expandable() ? "\<C-e><Plug>(coc-snippets-expand)"
            \                                 : coc#_select_confirm()
            \              : coc#expandable() ? "<Plug>(coc-snippets-expand)"
            \                                 : <SID>CheckBackSpace() ? "\<TAB>"
            \                                                         : coc#refresh()
inoremap <silent><expr> <S-TAB> coc#refresh()
" imap <silent><expr> <BS> join(["<BS>", coc#refresh()], "")

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

function! s:ShowDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

let g:coc_snippet_next = "<C-l>"
let g:coc_snippet_prev = "<C-h>"

nmap <silent> <leader>j <Plug>(coc-definition)
nmap <silent> <leader>J <Plug>(coc-declaration)
nmap <silent> <leader>x <Plug>(coc-fix-current)
nmap <silent> <leader>I <Plug>(coc-implementation)
nmap <silent> <leader>R <Plug>(coc-references)
nmap <silent> <leader>T <Plug>(coc-type-definition)

" nmap <silent> <leader>ld <Plug>(coc-diagnostic-info)
nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>la <Plug>(coc-codeaction)
nmap <silent> <leader>ll <Plug>(coc-codelens-action)

nmap <silent> <leader>lf <Plug>(coc-format)
vmap <silent> <leader>lf <Plug>(coc-format-selected)
nmap <silent> g== <Plug>(coc-format)
vmap <silent> g= <Plug>(coc-format-selected)
nmap <silent> g= <Plug>(coc-format-selected)

nmap <silent> <leader>lR <Plug>CocRefresh

nmap <silent> ]j <Plug>(coc-diagnostic-next)
nmap <silent> [j <Plug>(coc-diagnostic-prev)

nnoremap <silent> <leader>t :call CocAction('doHover')<CR>
nnoremap <silent> <leader>d :CocList --normal diagnostics<CR>
nnoremap <silent> <leader>le :CocList extensions<CR>
nnoremap <silent> <leader>ls :call CocAction('workspaceSymbols')<CR>

" ccls
nnoremap <silent> <leader><UP> :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<CR>
nnoremap <silent> <leader><DOWN> :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<CR>
nnoremap <silent> <leader><LEFT> :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<CR>
nnoremap <silent> <leader><RIGHT> :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<CR>

nnoremap <silent> <leader>lb :call CocLocations('ccls','$ccls/inheritance')<CR>
nnoremap <silent> <leader>lB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<CR>
nnoremap <silent> <leader>ld :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<CR>
nnoremap <silent> <leader>lD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<CR>

nnoremap <silent> <leader>lc :call CocLocations('ccls','$ccls/call')<CR>
nnoremap <silent> <leader>lC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<CR>

nnoremap <silent> <leader>lm :call CocLocations('ccls','$ccls/member')<CR>
nnoremap <silent> <leader>lM :call CocLocations('ccls','$ccls/member',{'kind':3})<CR>
nnoremap <silent> <leader>lt :call CocLocations('ccls','$ccls/member',{'kind':2})<CR>

nnoremap <silent> <leader>lv :call CocLocations('ccls','$ccls/vars',{'kind':1})<CR>
nnoremap <silent> <leader>lV :call CocLocations('ccls','$ccls/vars')<CR>

let g:coc_enable_locationlist = 0

augroup myCoc
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Disable locationlist auto preview
    autocmd User CocLocationsChange CocList --normal location
augroup END

" -- ALE --
let g:ale_disable_lsp = 1
let g:ale_linters = {
            \ 'cpp': ['CppCheck'],
            \ 'bzl': ['Buildifier'],
            \ }
let g:ale_linters_explicit = 1
let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 0
let g:ale_sign_offset = 1000

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✗'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0

call ale#linter#Define('cpp', {
            \   'name': 'CppCheck',
            \   'output_stream': 'both',
            \   'executable': 'cppcheck',
            \   'command': "%e -q --language=c++ --enable=all --platform=unix64 ".
            \              "--suppress=unusedFunction ".
            \              "--suppress=unusedStructMember ".
            \              "--template='{file}:{line}:{column} {severity}:{id}:{message}' ".
            \              "--template-location='{file}:{line}:{column} {info}' %t",
            \   'callback': 'HandleCppCheckFormat',
            \})

function HandleCppCheckFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+) (.+):(.+):(.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': str2nr(l:match[2]),
                        \   'col': str2nr(l:match[3]),
                        \   'type': l:match[4] is# 'error' ? 'E' : 'W',
                        \   'code': l:match[5],
                        \   'text': l:match[6],
                        \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                        \             ."\ntype: ". l:match[4]
                        \             ."\ncode: ". l:match[5]
                        \             ."\ntext: ". l:match[6],
                        \})
        endif
    endfor

    let l:pattern_location = '\v^(.+):(\d+):(\d+) (.+)$'
    for l:match in ale#util#GetMatches(a:lines, l:pattern_location)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            let l:lnum = str2nr(l:match[2])
            let l:flag = 1
            for l:item in l:output
                if l:lnum == l:item['lnum'] && l:item['type'] != 'I'
                    let l:flag = 0
                    break
                endif
            endfor
            if l:flag == 1
                call add(l:output, {
                            \   'lnum': l:lnum,
                            \   'col': str2nr(l:match[3]),
                            \   'type': 'I',
                            \   'code': '~',
                            \   'text': l:match[4],
                            \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                            \             ."\ntext: ". l:match[4],
                            \})
            endif
        endif
    endfor

    return l:output
endfunction

call ale#linter#Define('bzl', {
\   'name': 'Buildifier',
\   'output_stream': 'both',
\   'executable': 'buildifier',
\   'command': '%e --lint=warn --format=json --mode=check %t',
\   'callback': 'HandleBuildifierFormat',
\})

function HandleBuildifierFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+): (.+)$'
    let l:output = []
    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': l:match[2],
                        \   'col': l:match[3],
                        \   'type': 'E',
                        \   'code': '~',
                        \   'text': l:match[4],
                        \   'detail': l:match[1]
                        \             .':'. l:match[2]
                        \             .':'. l:match[3]
                        \             ."\ntext: ". l:match[4]
                        \})
        endif
    endfor
    if len(l:output) >= 1
        return l:output
    endif

    let l:json = json_decode(a:lines[0])
    if l:json['success']
        return []
    endif

    for l:file in l:json["files"]
        for l:warning in l:file["warnings"]
            if ale#path#IsBufferPath(a:buffer, l:file["filename"])
                call add(l:output, {
                            \   'lnum': l:warning["start"]["line"],
                            \   'end_lnum': l:warning["end"]["line"],
                            \   'col': l:warning["start"]["column"],
                            \   'end_col': l:warning["end"]["column"],
                            \   'type': 'W',
                            \   'code': l:warning["category"],
                            \   'text': l:warning["message"],
                            \   'detail': l:file["filename"]
                            \             .':'. l:warning["start"]["line"]
                            \             .':'. l:warning["start"]["column"]
                            \             .' -> '. l:warning["end"]["line"]
                            \             .':'. l:warning["end"]["column"]
                            \             ."\ncode: ". l:warning["category"]
                            \             ."\ntext: ". l:warning["message"]
                            \             ."\nurl: ". l:warning["url"],
                            \})
            endif
        endfor
    endfor

    return l:output
endfunction

function ALEDiags()
    let g:ale_set_quickfix = 1
    ALELint
    belowright copen
    autocmd myALE WinLeave *
                \ if &buftype == 'quickfix' |
                \     let g:ale_set_quickfix = 0 |
                \     autocmd! myALE WinLeave |
                \ endif
endfunction

augroup myALE
    autocmd!
    autocmd BufRead * ALELint
augroup END

nnoremap <silent><buffer> <leader>D :call ALEDiags()<CR>
nnoremap <leader>e :ALEDetail<CR>
nmap [w <Plug>(ale_previous)
nmap ]w <Plug>(ale_next)
nmap [W <Plug>(ale_first)
nmap ]W <Plug>(ale_last)

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
vnoremap <leader>a :Autoformat<CR>

"-- vim-rooter --
let g:rooter_manual_only = 1

"-- markdown-preview --
nnoremap <leader>mp :MarkdownPreview<CR>

"-- vim-table-mode --
let g:table_mode_map_prefix = '<leader>m'
let g:table_mode_toggle_map = 'm'
let g:table_mode_realign_map = '<Leader>mr'
let g:table_mode_delete_row_map = '<leader>md'
let g:table_mode_delete_column_map = '<leader>mc'
let g:table_mode_add_formula_map = '<leader>mf'
let g:table_mode_eval_formula_map = '<leader>me'
let g:table_mode_echo_cell_map = '<leader>m?'
let g:table_mode_sort_map = '<leader>ms'
let g:table_mode_tableize_map = '<leader>mt'
let g:table_mode_tableize_d_map = '<leader>mT'

"-- startify --
nnoremap <leader>S :call BufferDo('Startify')<CR>
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [
            \ {'v': '~/.vim/vimrc'},
            \ {'p': '~/.vim/vimrc.plug'},
            \ {'c': '~/.vim/coc-settings.json'},
            \ {'s': '~/.vim/plug/coc.nvim/data/schema.json'},
            \ {'b': '~/.bashrc'},
            \ ]
let g:startify_skiplist = [
            \ $HOME .'/.vim',
            \ $HOME .'/.bashrc',
            \ "/usr/share/nvim",
            \ "/usr/share/vim",
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

" COC mapping the 'af' and 'if' for LS function textobj, but it doesn't work now
augroup myTextobj
    autocmd!
    autocmd BufRead * call <SID>AutoCmdTextobj()
augroup END
function s:AutoCmdTextobj() abort
    xmap af <Plug>(textobj-function-a)
    omap af <Plug>(textobj-function-a)
    xmap if <Plug>(textobj-function-i)
    omap if <Plug>(textobj-function-i)
endfunction

"-- BufKill --
let g:BufKillCreateMappings = 0

nnoremap <silent> <leader>o :call BufferDo('BB')<CR>
nnoremap <silent> <leader>i :call BufferDo('BF')<CR>
nnoremap <silent> <leader>` :call BufferDo('BA')<CR>
nnoremap <silent> <leader>u :call BufferDo('BUNDO')<CR>

nnoremap <silent> + :call BufferDo('bn')<CR>
nnoremap <silent> _ :call BufferDo('bp')<CR>
vnoremap <silent> + :<C-u>call BufferDo('bn')<CR>
vnoremap <silent> _ :<C-u>call BufferDo('bp')<CR>
nnoremap <silent> <leader>q :BW<CR>
nnoremap <silent> <leader>Q :BD<CR>

"-- Gundo --
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
nnoremap <leader>G :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_width = 70
let g:gundo_preview_height = 15
let g:gundo_close_on_revert = 1
" let g:gundo_auto_preview = 0

"-- Undotree --
nnoremap <leader>U :UndotreeToggle<CR>
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 70
let g:undotree_DiffpanelHeight = 15

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

"-- vim-easy-align --
vmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"-- vim-better-whitespace --
nnoremap <silent> ]$ :NextTrailingWhitespace<CR>
nnoremap <silent> [$ :PrevTrailingWhitespace<CR>

"-- vim-interestinwords --
nnoremap <silent> <leader>k :call InterestingWords('n')<CR>
vmap <leader>k <Plug>InterestingWords

nnoremap <silent> <BS> :call UncolorAllWords()<CR>:nohlsearch<CR>
let g:interestingWordsTermColors = ['002', '004', '005', '006', '013', '009']

"-- vim-searchindex --
function IsSearch() abort
    let l:origin_pos = getpos('.')
    call search(@/, 'c')
    if l:origin_pos == getpos('.')
        let l:is_search = 1
    else
        let l:is_search = 0
    endif
    call setpos('.', l:origin_pos)
    return l:is_search
endfunction

function s:UserPrintMatches() abort
    if IsSearch() == 1
        SearchIndex
    endif
endfunction
command -bar UserSearchIndex call <SID>UserPrintMatches()

nnoremap <silent> n :silent call WordNavigation(1)<CR>:UserSearchIndex<CR>
            \:if IsSearch() == 1<CR>let v:hlsearch = 1<CR>endif<CR>
nnoremap <silent> N :silent call WordNavigation(0)<CR>:UserSearchIndex<CR>
            \:if IsSearch() == 1<CR>let v:hlsearch = 1<CR>endif<CR>

let g:star_echo_search_pattern = 0

"-- vim-star --
vmap <silent> * <Plug>(star-*):SearchIndex<CR>
vmap <silent> # <Plug>(star-#):SearchIndex<CR>
nmap <silent> * <Plug>(star-*):SearchIndex<CR>
nmap <silent> # <Plug>(star-#):SearchIndex<CR>
nmap <silent> g* <Plug>(star-g*):SearchIndex<CR>
nmap <silent> g# <Plug>(star-g#):SearchIndex<CR>

"-- vim-devicons --
let g:webdevicons_enable_nerdtree = 0

"-- xterm-color-table --
let g:XtermColorTableDefaultOpen = 'vertical botright vsplit'
augroup myXtermColorTable
    autocmd!
    autocmd BufEnter __XtermColorTable__ call <SID>AutoCmdXtermColorTable()
augroup END
function s:AutoCmdXtermColorTable() abort
    set bufhidden=delete
    set nobuflisted
    set nonumber
endfunction

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
let g:yankring_history_dir = s:vim_cache
augroup myYankRing
    autocmd!
    autocmd BufEnter \[YankRing\] cnoreabbrev <silent><buffer> q YRShow
augroup END
if has('nvim')
    let g:yankring_clipboard_monitor = 0
endif

"-- conflict-marker.vim --
let g:conflict_marker_enable_mappings = 0
nmap ]k <Plug>(conflict-marker-next-hunk)
nmap [k <Plug>(conflict-marker-prev-hunk)

nmap <leader>cj <Plug>(conflict-marker-themselves)
nmap <leader>ck <Plug>(conflict-marker-ourselves)
nmap <leader>cn <Plug>(conflict-marker-none)
nmap <leader>cb <Plug>(conflict-marker-both)

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

nmap <Plug>SwapItFallbackIncrement :<C-u>call FallbackIncrement()<CR>
nmap <Plug>SwapItFallbackDecrement :<C-u>call FallbackDecrement()<CR>

function FallbackIncrement()
    nnoremap <Plug>SwapItFallbackIncrement <C-a>
    call <SID>LocateNumber()
    execute "normal ". v:count1 ."\<Plug>SwapIncrement"
    nnoremap <Plug>SwapItFallbackIncrement :<C-u>call FallbackIncrement()<CR>
endfunction

function FallbackDecrement()
    nnoremap <Plug>SwapItFallbackDecrement <C-x>
    call <SID>LocateNumber()
    execute "normal ". v:count1 ."\<Plug>SwapDecrement"
    nnoremap <Plug>SwapItFallbackDecrement :<C-u>call FallbackDecrement()<CR>
endfunction

let g:true_false_pattern = '\v<[Tt]rue>|<[Ff]alse>|<TRUE>|<FALSE>'
let g:oct_number_pattern = '\d*\zs\d'
let g:hex_number_pattern = '0(x|X)\x*\zs\x'
let g:bin_number_pattern = '0(b|B)[01]*\zs[01]'
let g:full_pattern = join([g:true_false_pattern, g:hex_number_pattern, g:bin_number_pattern, g:oct_number_pattern], '|')

function s:LocateNumber() abort
    let l:pos = getpos('.')
    let l:flag = search(g:true_false_pattern, 'cb', line('.'))
    let l:col = col('.')
    call setpos('.', l:pos)
    if l:flag != 0 && l:pos[2] < l:col + strlen(expand('<cword>'))
        return
    endif
    call search(g:full_pattern, 'c', line('.'))
endfunction

"-- vim-protodef --
let g:protodefprotogetter = '~/.vim/plug/vim-protodef/pullproto.pl'
let disable_protodef_mapping = 1
" let g:disable_protodef_sorting = 1
function s:ProtoDef(includeNS) abort
    if a:includeNS == 1
        let l:protos = protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})
    else
        let l:protos = protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS' : 0})
    endif
    call append(line("."), split(l:protos, '\n'))
endfunction
command ProtoDef call <SID>ProtoDef(1)

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
nnoremap <F4> :WhichKey ''<CR>
vnoremap <F4> :WhichKeyVisual ''<CR>
nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>
let g:which_key_use_floating_win = 0
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
    IndentLinesToggle
    if &number
        set signcolumn=auto
        echo "Sidebar On"
    else
        set signcolumn=no
        echo "Sidebar Off"
    endif
endfunction
