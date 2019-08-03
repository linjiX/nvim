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

source ~/.vim/common/common.vim
source ~/.vim/plug.vim
source ~/.vim/common/colorscheme.vim
let g:solarized_termtrans = 1
colorscheme solarized
" colorscheme molokai

source ~/.vim/common/quickfix.vim
source ~/.vim/common/terminal.vim

let s:vim_tags = expand('~/.cache/tags')
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"-- largefile --
let g:LargeFile = 10

"-- NERDTree & Tagbar --
source ~/.vim/config/nerdtree.vim

"-- NERDCommenter --
source ~/.vim/config/comment.vim

"-- fugitive --
source ~/.vim/config/git.vim

" -- CrtlSF --
source ~/.vim/config/ctrlsf.vim

" -- FZF --
source ~/.vim/config/fzf.vim

" -- LeaderF --
let g:Lf_WindowHeight = 0.3
let g:Lf_StlSeparator = {'left': '', 'right': ''}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ReverseOrder = 1
let g:Lf_DefaultMode = 'NameOnly'

let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''
nnoremap <expr><silent> <C-p> BufferCmd(":Leaderf file\<CR>")
nnoremap <expr><silent> <leader>ff BufferCmd(":Leaderf file\<CR>")
nnoremap <expr><silent> <leader>fb BufferCmd(":Leaderf buffer\<CR>")
nnoremap <expr><silent> <leader>fB BufferCmd(":Leaderf buffer --all\<CR>")
nnoremap <expr><silent> <leader>fm BufferCmd(":Leaderf mru --cwd\<CR>")
nnoremap <expr><silent> <leader>fM BufferCmd(":Leaderf mru\<CR>")
nnoremap <expr><silent> <leader>ft BufferCmd(":Leaderf bufTag\<CR>")
nnoremap <expr><silent> <leader>fT BufferCmd(":Leaderf bufTag --all\<CR>")
nnoremap <expr><silent> <leader>fu BufferCmd(":Leaderf function\<CR>")
nnoremap <expr><silent> <leader>fU BufferCmd(":Leaderf function --all\<CR>")
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
source ~/.vim/config/asyncrun.vim

" -- unimpaired --
source ~/.vim/config/unimpaired.vim

" -- Airline --
source ~/.vim/config/airline.vim

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
source ~/.vim/config/ale.vim

" -- UltiSnips --
let g:UltiSnipsExpandTrigger = '<C-k>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" -- vim-slime --
source ~/.vim/config/slime.vim

" -- python-mode --
source ~/.vim/config/pymode.vim

" -- vim-cpp-enhanced-highlight --
source ~/.vim/config/polyglot.vim

"-- FSwitch --
source ~/.vim/config/fswitch.vim

"-- vim-smooth-scroll --
source ~/.vim/config/smooth-scroll.vim

"-- vim-autoformat --
source ~/.vim/config/autoformat.vim

"-- vim-rooter --
let g:rooter_manual_only = 1

"-- markdown-preview --
source ~/.vim/config/markdown.vim

"-- startify --
source ~/.vim/config/startify.vim

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
source ~/.vim/config/bufkill.vim

"-- Gundo --
source ~/.vim/config/undo.vim

"-- vim-sneak --
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"-- vim-expand-region --
map <leader>= <Plug>(expand_region_expand)
map <leader>- <Plug>(expand_region_shrink)

"-- rainbow --
source ~/.vim/config/rainbow.vim

"-- vim-easy-align --
vmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"-- vim-better-whitespace --
nnoremap <silent> ]$ :NextTrailingWhitespace<CR>
nnoremap <silent> [$ :PrevTrailingWhitespace<CR>

"-- vim-interestinwords --
source ~/.vim/config/interestingwords.vim

source ~/.vim/config/star.vim

"-- vim-devicons --
let g:webdevicons_enable_nerdtree = 0

"-- xterm-color-table --
source ~/.vim/config/xterm-color-table.vim

"-- vim-highlight-cursor-words --
let g:HiCursorWords_delay = 50
let g:HiCursorWords_linkStyle='CursorLine'

"-- vim-peekaboo --
let g:peekaboo_window = "vertical botright 50new"
let g:peekaboo_delay = 1000

"-- vim-choosewin --
let g:choosewin_label = '123456789'
let g:choosewin_tablabel = 'ABCDEFGHIJKLMNOPQRTUVWYZ'

nmap <leader>W <Plug>(choosewin)
" let g:choosewin_overlay_enable = 1

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
" nnoremap <silent> <leader>P :YRShow<CR>
" nnoremap <silent> <leader>p :YRGetElem 1<CR>
" nnoremap <silent> <leader>yc :YRClear<CR>
" let g:yankring_replace_n_pkey = ''
" let g:yankring_replace_n_nkey = ''
" let g:yankring_max_history = 20
" let g:yankring_history_dir = s:vim_tags
" augroup myYankRing
"     autocmd!
"     autocmd BufEnter \[YankRing\] cnoreabbrev <silent><buffer> q YRShow
" augroup END
" if has('nvim')
"     let g:yankring_clipboard_monitor = 0
" endif

"-- conflict-marker.vim --

"-- swapit --
source ~/.vim/config/swapit.vim

"-- vim-protodef --
source ~/.vim/config/protodef.vim

"-- vim-visual-multi --
" let g:VM_maps = {}
" let g:VM_maps["Select l"] = '<C-Right>'
" let g:VM_maps["Select h"] = '<C-Left>'

"-- vim-which-key --
source ~/.vim/config/which-key.vim

"-- limelight --
nnoremap <F3> :Limelight!!<CR>
let g:limelight_conceal_ctermfg = '10'

"-- quickmenu --
source ~/.vim/config/quickmenu.vim
