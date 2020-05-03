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

if !has('nvim')
    set termwinkey=<C-v>
endif

augroup myTerminal
    autocmd!
    if has('nvim')
        autocmd TermOpen * call terminal#AutoCmdTermOpen()
        autocmd TermClose * call terminal#AutoCmdTermClose()
        autocmd BufEnter term://* call terminal#AutoCmdNavigate()
    else
        autocmd TerminalOpen * call terminal#AutoCmdTermOpen()
        autocmd QuitPre * call terminal#AutoCmdWipeTerminal()
    endif
augroup END

nnoremap <silent> <C-n> :call terminal#SmartOpen('bash')<CR>
nnoremap <silent> <leader>ei :call terminal#SmartOpen('ipython')<CR>
nnoremap <silent> <leader>eb :call terminal#SmartOpen('bpython')<CR>
nnoremap <silent> <leader>et :call terminal#SmartOpen('ptpython')<CR>
nnoremap <silent> <leader>eh :call terminal#SmartOpen('htop')<CR>

tnoremap <ESC><ESC> <C-\><C-n>
tnoremap <expr><silent> <C-d> terminal#Detach()
tnoremap <expr><silent> <C-h> terminal#Navigate('h')
tnoremap <expr><silent> <C-j> terminal#Navigate('j')
tnoremap <expr><silent> <C-k> terminal#Navigate('k')
tnoremap <expr><silent> <C-l> terminal#Navigate('l')
