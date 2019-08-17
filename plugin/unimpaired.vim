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

function s:MouseToggle() abort
    return &mouse ==# '' ? ":set mouse=a\<CR>"
                \        : ":set mouse=\<CR>"
endfunction

function s:SigncolumnToggle() abort
    return &signcolumn ==# 'no' ? ":setlocal signcolumn=auto\<CR>"
                \               : ":setlocal signcolumn=no\<CR>"
endfunction

function s:SidebarOn() abort
    set number
    set signcolumn=auto
    IndentLinesEnable
endfunction

function s:SidebarOff() abort
    set nonumber
    set signcolumn=no
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
endfunction

function s:ListOff() abort
    DisableWhitespace
    setlocal nolist
endfunction

function s:ListToggle() abort
    if &list
        call s:ListOff()
        echo ':setlocal nolist'
    else
        call s:ListOn()
        echo ':setlocal list'
    endif
endfunction

nmap [om :set mouse=a<CR>
nmap ]om :set mouse=<CR>
nmap <expr> yom <SID>MouseToggle()

nmap [oS :setlocal signcolumn=auto<CR>
nmap ]oS :setlocal signcolumn=no<CR>
nmap <expr> yoS <SID>SigncolumnToggle()

" Plug 'Yggdroot/indentLine'
nmap [oI :IndentLinesEnable<CR>
nmap ]oI :IndentLinesDisable<CR>
nmap yoI :IndentLinesToggle<CR>

nmap <silent> [oa :call <SID>SidebarOn()<CR>
nmap <silent> ]oa :call <SID>SidebarOff()<CR>
nmap <silent> yoa :call <SID>SidebarToggle()<CR>

nmap <silent> [ol :call <SID>ListOn()<CR>
nmap <silent> ]ol :call <SID>ListOff()<CR>
nmap <silent> yol :call <SID>ListToggle()<CR>

nmap <expr> [a buffer#Open('<Plug>unimpairedAPrevious')
nmap <expr> ]a buffer#Open('<Plug>unimpairedANext')
nmap <expr> [A buffer#Open('<Plug>unimpairedAFirst')
nmap <expr> ]A buffer#Open('<Plug>unimpairedALast')

nmap <expr> [b buffer#Open('<Plug>unimpairedBPrevious')
nmap <expr> ]b buffer#Open('<Plug>unimpairedBNext')
nmap <expr> [B buffer#Open('<Plug>unimpairedBFirst')
nmap <expr> ]B buffer#Open('<Plug>unimpairedBLast')

nmap <expr> [f buffer#Open('<Plug>unimpairedDirectoryPrevious')
nmap <expr> ]f buffer#Open('<Plug>unimpairedDirectoryNext')

nmap <expr> [l buffer#Open('<Plug>unimpairedLPrevious')
nmap <expr> ]l buffer#Open('<Plug>unimpairedLNext')
nmap <expr> [L buffer#Open('<Plug>unimpairedLFirst')
nmap <expr> ]L buffer#Open('<Plug>unimpairedLLast')
nmap <expr> [<C-l> buffer#Open('<Plug>unimpairedLPFile')
nmap <expr> ]<C-l> buffer#Open('<Plug>unimpairedLNFile')

nmap <expr> [q buffer#Open('<Plug>unimpairedQPrevious')
nmap <expr> ]q buffer#Open('<Plug>unimpairedQNext')
nmap <expr> [Q buffer#Open('<Plug>unimpairedQFirst')
nmap <expr> ]Q buffer#Open('<Plug>unimpairedQLast')
nmap <expr> [<C-q> buffer#Open('<Plug>unimpairedQPFile')
nmap <expr> ]<C-q> buffer#Open('<Plug>unimpairedQNFile')

" Plug 'chxuan/change-colorscheme'
nnoremap <silent> ]r :NextColorScheme<CR>
nnoremap <silent> [r :PreviousColorScheme<CR>

" Plug 'ntpeters/vim-better-whitespace'
nnoremap <silent> ]$ :NextTrailingWhitespace<CR>
nnoremap <silent> [$ :PrevTrailingWhitespace<CR>

nmap [oL :EnableWhitespace<CR>
nmap ]oL :DisableWhitespace<CR>
nmap yoL :ToggleWhitespace<CR>
