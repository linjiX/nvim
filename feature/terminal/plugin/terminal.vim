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

augroup myTerminal
    autocmd!
    if has('nvim')
        autocmd TermOpen * call terminal#AutoCmdTerminal()
        autocmd TermClose * quit
        autocmd BufEnter term://* call terminal#AutoCmdNvimTerminal()
    else
        autocmd TerminalOpen * call terminal#AutoCmdTerminal()
    endif
augroup END

nnoremap <silent> <C-n> :call terminal#SmartTerminal('bash')<CR>
nnoremap <silent> <leader>ei :call terminal#SmartTerminal('ipython')<CR>
nnoremap <silent> <leader>eb :call terminal#SmartTerminal('bpython')<CR>
nnoremap <silent> <leader>et :call terminal#SmartTerminal('ptpython')<CR>
nnoremap <silent> <leader>eh :call terminal#SmartTerminal('htop')<CR>

tnoremap <ESC><ESC> <C-\><C-n>
if has('nvim')
    tmap <expr><silent> <C-h> terminal#Navigate("\<C-h>")
    tmap <expr><silent> <C-j> terminal#Navigate("\<C-j>")
    tmap <expr><silent> <C-k> terminal#Navigate("\<C-k>")
    tmap <expr><silent> <C-l> terminal#Navigate("\<C-k>")
else
    set termwinkey=<C-v>
    tnoremap <C-h> <C-v>h
    tnoremap <C-j> <C-v>j
    tnoremap <C-k> <C-v>k
    tnoremap <C-l> <C-v>l
endif
