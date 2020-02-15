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

" Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'floating'

" Plug 'neoclide/coc.nvim'
let g:coc_enable_locationlist = 0

let g:coc_snippet_next = '<C-l>'
let g:coc_snippet_prev = '<C-h>'

function! s:CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc-xml
let s:java_home =
            \ has('macunix') ? '/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
            \                : '/usr/lib/jvm/java-8-openjdk-amd64'
call coc#config('xml.java.home', s:java_home)

function! s:ShowDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function s:AutoCmdCocInfo() abort
    if &buftype ==# 'nofile'
        setlocal nobuflisted
        setlocal bufhidden=wipe
    endif
endfunction

function s:AutoCmdCocExplorer() abort
    nnoremap <buffer> <leader> <Nop>
    setlocal noswapfile
endfunction

augroup myCoc
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent! call CocActionAsync('highlight')
    " Disable locationlist auto preview
    autocmd User CocLocationsChange CocList --normal location
    autocmd FileType coc-explorer call s:AutoCmdCocExplorer()
    autocmd FileType log call s:AutoCmdCocInfo()
augroup END

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

nmap <silent> <leader>A <Plug>(coc-format)
vmap <silent> <leader>A <Plug>(coc-format-selected)
nmap <silent> g= <Plug>(coc-format-selected)
" nmap <silent> g== <Plug>(coc-format)
" vmap <silent> g= <Plug>(coc-format-selected)

" nmap <silent> <leader>lR <Plug>CocRefresh
nmap <silent> <leader>lh <Plug>(coc-float-hide)

nmap <silent> ]j <Plug>(coc-diagnostic-next)
nmap <silent> [j <Plug>(coc-diagnostic-prev)

nnoremap <silent> <leader>tt :call CocAction('doHover')<CR>
nnoremap <silent> <leader>d :CocList --normal diagnostics<CR>
nnoremap <silent> <leader>le :CocList --normal extensions<CR>
nnoremap <silent> <leader>ls :call CocAction('workspaceSymbols')<CR>
nnoremap <silent> <leader>lx :CocCommand<CR>

nnoremap <silent> <leader>p :CocList --normal yank<CR>

" coc-translator
nmap <silent> <leader>tp <Plug>(coc-translator-p)
nmap <silent> <leader>te <Plug>(coc-translator-e)
nmap <silent> <leader>tr <Plug>(coc-translator-r)
nnoremap <silent> <leader>tl :CocList --normal translation<CR>

" coc-explorer
nnoremap <silent> <leader>w :call workspace#ToggleWorkspace()<CR>
nnoremap <silent> <leader>W :call workspace#RevealWorkspace()<CR>

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
