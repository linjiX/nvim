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

let g:BufKillCreateMappings = 0

if has('nvim')
    function s:AutoCmdBufKill() abort
        if exists('w:BufKillList') && index(w:BufKillList, bufnr()) == -1
            unlet w:BufKillList
            unlet w:BufKillIndex
            unlet w:BufKillColumnList
        endif
    endfunction

    augroup myBufKill
        autocmd!
        autocmd BufLeave * call s:AutoCmdBufKill()
    augroup END
endif

" nnoremap <expr><silent> <leader>o buffer#Open(":BB\<CR>")
" nnoremap <expr><silent> <leader>i buffer#Open(":BF\<CR>")
nnoremap <expr><silent> <leader>` buffer#Open(":BA\<CR>")
nnoremap <expr><silent> <leader>u buffer#Open(":BUNDO\<CR>")

nnoremap <expr><silent> + buffer#Open(":bn\<CR>")
nnoremap <expr><silent> _ buffer#Open(":bp\<CR>")
xnoremap <expr><silent> + buffer#Open(":\<C-u>bn\<CR>")
xnoremap <expr><silent> _ buffer#Open(":\<C-u>bp\<CR>")
nnoremap <silent> <leader>q :BW<CR>
nnoremap <silent> <leader>Q :BD<CR>
