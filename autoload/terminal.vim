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

function terminal#AutoCmdTerminal() abort
    " setlocal bufhidden=wipe
    setlocal nobuflisted
    nnoremap <silent><buffer> <leader>q :q!<CR>
    nnoremap <silent><buffer> q :q!<CR>
    cnoreabbrev <buffer> q q!
    if has('nvim')
        setlocal bufhidden=wipe
        startinsert
    endif
endfunction

function terminal#AutoCmdWipeTerminal() abort
    if &buftype ==# 'terminal'
        set bufhidden=wipe
    endif
endfunction

function terminal#AutoCmdNvimTerminal() abort
    if exists('b:terminal_navigate')
        unlet b:terminal_navigate
        startinsert
    endif
endfunction
