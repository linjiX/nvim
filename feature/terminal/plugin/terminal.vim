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

if !has('nvim')
    set termwinkey=<C-v>
endif

augroup myTerminal
    autocmd!
    if has('nvim')
        autocmd TermOpen * call terminal#AutoCmdTermOpen()
        autocmd TermClose * bwipeout!
        autocmd BufEnter term://* call terminal#AutoCmdInsert()
    else
        autocmd TerminalOpen * call terminal#AutoCmdTermOpen()
    endif
augroup END

nnoremap <expr><silent> <M-a> terminal#New()
tnoremap <expr><silent> <M-a> terminal#New()

if has('nvim') || has('gui_running')
    tnoremap <expr><silent> <M-[> terminal#Select('previous')
    tnoremap <expr><silent> <M-]> terminal#Select('next')
else
    tnoremap <expr><silent> <ESC>[ terminal#Select('previous')
    tnoremap <expr><silent> <ESC>] terminal#Select('next')
endif

nnoremap <silent> <C-n> :call terminal#SmartOpen('')<CR>
nnoremap <silent> <leader>ed :call terminal#Attach()<CR>
nnoremap <silent> <leader>ei :call terminal#SmartOpen('ipython')<CR>
nnoremap <silent> <leader>eb :call terminal#SmartOpen('bpython')<CR>
nnoremap <silent> <leader>et :call terminal#SmartOpen('ptpython')<CR>
nnoremap <silent> <leader>eh :call terminal#SmartOpen('htop')<CR>

tnoremap <ESC><ESC> <C-\><C-n>
tnoremap <expr><silent> <C-o> terminal#Detach()
tnoremap <expr><silent> <C-h> terminal#Navigate('h')
tnoremap <expr><silent> <C-j> terminal#Navigate('j')
tnoremap <expr><silent> <C-k> terminal#Navigate('k')
tnoremap <expr><silent> <C-l> terminal#Navigate('l')

command! -nargs=* Terminal call terminal#Open(<q-mods>, <q-args>)
