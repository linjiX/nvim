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
