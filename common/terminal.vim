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

function s:AutoCmdTerminal() abort
    set bufhidden=wipe
    set nobuflisted
    " set nomodifiable
    nnoremap <silent><buffer> <leader>q :q!<CR>
    nnoremap <silent><buffer> q :q!<CR>
    cnoreabbrev <buffer> q q!
endfunction

augroup myTerminal
    autocmd!
    if has('nvim')
        autocmd TermOpen * call <SID>AutoCmdTerminal()
        autocmd TermOpen * nnoremap <silent><buffer> i :set nonumber<CR>i
    else
        autocmd TerminalOpen * call <SID>AutoCmdTerminal()
    endif
augroup END

if has('nvim')
    cnoreabbrev terminal botright vsplit term://bash
    nnoremap <silent> <C-t> :botright vsplit term://bash<CR>
    tnoremap <silent> <ESC> <C-\><C-n>:set number<CR>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
else
    set termwinkey=<C-v>
    nnoremap <silent> <C-t> :vertical botright terminal<CR>
    tnoremap <ESC><ESC> <C-\><C-n>
    tnoremap <C-h> <C-v>h
    tnoremap <C-j> <C-v>j
    tnoremap <C-k> <C-v>k
    tnoremap <C-l> <C-v>l
    tnoremap <C-v>n <Nop>
endif
