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

function s:MouseToggle() abort
    return &mouse ==# '' ? ":set mouse=a\<CR>"
                \        : ":set mouse=\<CR>"
endfunction

function s:SigncolumnToggle() abort
    return &signcolumn ==# 'no' ? ":setlocal signcolumn=auto\<CR>"
                \               : ":setlocal signcolumn=no\<CR>"
endfunction

function s:ConcealToggle() abort
    return &conceallevel !=# 0 ? ":setlocal conceallevel=0\<CR>"
                \              : ":setlocal conceallevel=2\<CR>"
endfunction

function s:FoldToggle() abort
    return &foldmethod ==# 'manual' ? ":setlocal foldmethod=expr\<CR>"
                \                   : ":setlocal foldmethod=manual\<CR>"
endfunction

function s:SidebarOn() abort
    setlocal number
    setlocal signcolumn=number
    IndentLinesEnable
endfunction

function s:SidebarOff() abort
    setlocal nonumber
    setlocal signcolumn=no
    IndentLinesDisable
endfunction

function s:SidebarToggle() abort
    if &signcolumn ==# 'no'
        call s:SidebarOn()
    else
        call s:SidebarOff()
    endif
endfunction

function s:ListOn() abort
    EnableWhitespace
    setlocal list
    echo ':setlocal list'
endfunction

function s:ListOff() abort
    DisableWhitespace
    setlocal nolist
    echo ':setlocal nolist'
endfunction

function s:ListToggle() abort
    if &list
        call s:ListOff()
    else
        call s:ListOn()
    endif
endfunction

nmap [om :set mouse=a<CR>
nmap ]om :set mouse=<CR>
nmap <expr> yom <SID>MouseToggle()

nmap [og :setlocal signcolumn=auto<CR>
nmap ]og :setlocal signcolumn=no<CR>
nmap <expr> yog <SID>SigncolumnToggle()

nmap [oc :setlocal conceallevel=2<CR>
nmap ]oc :setlocal conceallevel=0<CR>
nmap <expr> yoc <SID>ConcealToggle()

nmap [of :setlocal foldmethod=expr<CR>
nmap ]of :setlocal foldmethod=manual<CR>
nmap <expr> yof <SID>FoldToggle()

nmap <silent> [oa :call <SID>SidebarOn()<CR>
nmap <silent> ]oa :call <SID>SidebarOff()<CR>
nmap <silent> yoa :call <SID>SidebarToggle()<CR>

nmap <silent> [ol :call <SID>ListOn()<CR>
nmap <silent> ]ol :call <SID>ListOff()<CR>
nmap <silent> yol :call <SID>ListToggle()<CR>

nmap <expr> [a utility#Open('<Plug>unimpairedAPrevious')
nmap <expr> ]a utility#Open('<Plug>unimpairedANext')
nmap <expr> [A utility#Open('<Plug>unimpairedAFirst')
nmap <expr> ]A utility#Open('<Plug>unimpairedALast')

nmap <expr> [b utility#Open('<Plug>unimpairedBPrevious')
nmap <expr> ]b utility#Open('<Plug>unimpairedBNext')
nmap <expr> [B utility#Open('<Plug>unimpairedBFirst')
nmap <expr> ]B utility#Open('<Plug>unimpairedBLast')

nmap <expr> [f utility#Open('<Plug>unimpairedDirectoryPrevious')
nmap <expr> ]f utility#Open('<Plug>unimpairedDirectoryNext')

nmap <expr> [l utility#Open('<Plug>unimpairedLPrevious')
nmap <expr> ]l utility#Open('<Plug>unimpairedLNext')
nmap <expr> [L utility#Open('<Plug>unimpairedLFirst')
nmap <expr> ]L utility#Open('<Plug>unimpairedLLast')
nmap <expr> [<C-l> utility#Open('<Plug>unimpairedLPFile')
nmap <expr> ]<C-l> utility#Open('<Plug>unimpairedLNFile')

nmap <expr> [q utility#Open('<Plug>unimpairedQPrevious')
nmap <expr> ]q utility#Open('<Plug>unimpairedQNext')
nmap <expr> [Q utility#Open('<Plug>unimpairedQFirst')
nmap <expr> ]Q utility#Open('<Plug>unimpairedQLast')
nmap <expr> [<C-q> utility#Open('<Plug>unimpairedQPFile')
nmap <expr> ]<C-q> utility#Open('<Plug>unimpairedQNFile')

" Plug 'chxuan/change-colorscheme'
nnoremap <silent> ]h :NEXTCOLOR<CR>
nnoremap <silent> [h :PREVCOLOR<CR>

" Plug 'ntpeters/vim-better-whitespace'
nnoremap <silent> ]. :NextTrailingWhitespace<CR>
nnoremap <silent> [. :PrevTrailingWhitespace<CR>

nmap [r. :EnableWhitespace<CR>
nmap ]r. :DisableWhitespace<CR>
nmap yr. :ToggleWhitespace<CR>
