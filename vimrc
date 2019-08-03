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

" let s:vim_cache = expand('~/.LfCache')
" if !isdirectory(s:vim_cache)
"     silent! call mkdir(s:vim_cache, 'p')
" endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- vim-plug --

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
nnoremap <expr><silent> <leader>fg BufferCmd(":Leaderf gtags\<CR>")
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
source ~/.vim/config/asyncrun.vim

" -- unimpaired --
source ~/.vim/config/unimpaired.vim

" -- Airline --
source ~/.vim/config/airline.vim

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
nmap <silent> <leader>lR <Plug>(coc-refactor)
nmap <silent> <leader>la <Plug>(coc-codeaction)
nmap <silent> <leader>ll <Plug>(coc-codelens-action)

nmap <silent> <leader>lf <Plug>(coc-format)
vmap <silent> <leader>lf <Plug>(coc-format-selected)
nmap <silent> g== <Plug>(coc-format)
vmap <silent> g= <Plug>(coc-format-selected)
nmap <silent> g= <Plug>(coc-format-selected)

" nmap <silent> <leader>lR <Plug>CocRefresh
nmap <silent> <leader>lh <Plug>(coc-float-hide)
nmap <silent> <leader>lj <Plug>(coc-float-jump)

nmap <silent> ]j <Plug>(coc-diagnostic-next)
nmap <silent> [j <Plug>(coc-diagnostic-prev)

nnoremap <silent> <leader>t :call CocAction('doHover')<CR>
nnoremap <silent> <leader>d :CocList --normal diagnostics<CR>
nnoremap <silent> <leader>le :CocList extensions<CR>
nnoremap <silent> <leader>ls :call CocAction('workspaceSymbols')<CR>
nnoremap <silent> <leader>lx :CocCommand<CR>

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
source ~/.vim/config/ale.vim

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
" let g:yankring_history_dir = s:vim_cache
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
source ~/.vim/config/which-key.vim

"-- limelight --
nnoremap <F3> :Limelight!!<CR>
let g:limelight_conceal_ctermfg = '10'

"-- quickmenu --
source ~/.vim/config/quickmenu.vim
