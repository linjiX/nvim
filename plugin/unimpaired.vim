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

nmap [oa :call <SID>SidebarOn()<CR>
nmap ]oa :call <SID>SidebarOff()<CR>
nmap yoa :call <SID>SidebarToggle()<CR>

nmap <expr> [a BufferCmd('<Plug>unimpairedAPrevious')
nmap <expr> ]a BufferCmd('<Plug>unimpairedANext')
nmap <expr> [A BufferCmd('<Plug>unimpairedAFirst')
nmap <expr> ]A BufferCmd('<Plug>unimpairedALast')

nmap <expr> [b BufferCmd('<Plug>unimpairedBPrevious')
nmap <expr> ]b BufferCmd('<Plug>unimpairedBNext')
nmap <expr> [B BufferCmd('<Plug>unimpairedBFirst')
nmap <expr> ]B BufferCmd('<Plug>unimpairedBLast')

nmap <expr> [f BufferCmd('<Plug>unimpairedDirectoryPrevious')
nmap <expr> ]f BufferCmd('<Plug>unimpairedDirectoryNext')

nmap <expr> [l BufferCmd('<Plug>unimpairedLPrevious')
nmap <expr> ]l BufferCmd('<Plug>unimpairedLNext')
nmap <expr> [L BufferCmd('<Plug>unimpairedLFirst')
nmap <expr> ]L BufferCmd('<Plug>unimpairedLLast')
nmap <expr> [<C-l> BufferCmd('<Plug>unimpairedLPFile')
nmap <expr> ]<C-l> BufferCmd('<Plug>unimpairedLNFile')

nmap <expr> [q BufferCmd('<Plug>unimpairedQPrevious')
nmap <expr> ]q BufferCmd('<Plug>unimpairedQNext')
nmap <expr> [Q BufferCmd('<Plug>unimpairedQFirst')
nmap <expr> ]Q BufferCmd('<Plug>unimpairedQLast')
nmap <expr> [<C-q> BufferCmd('<Plug>unimpairedQPFile')
nmap <expr> ]<C-q> BufferCmd('<Plug>unimpairedQNFile')

" Plug 'chxuan/change-colorscheme'
nnoremap <silent> ]r :NextColorScheme<CR>
nnoremap <silent> [r :PreviousColorScheme<CR>

" Plug 'ntpeters/vim-better-whitespace'
nnoremap <silent> ]$ :NextTrailingWhitespace<CR>
nnoremap <silent> [$ :PrevTrailingWhitespace<CR>
