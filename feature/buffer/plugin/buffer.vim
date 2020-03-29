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

function s:WipeEmptyBuffer() abort
    if exists('b:stored_bufhidden')
        let &bufhidden = b:stored_bufhidden
        unlet b:stored_bufhidden
    endif
    if empty(bufname('%')) && line('$') == 1 && empty(getline(1))
        let b:stored_bufhidden = &bufhidden
        set bufhidden=wipe
    endif
endfunction

let g:buffer_reopen = []
function s:UpdateBufferUndo(filename) abort
    if !filereadable(a:filename)
        return
    endif

    let l:index = index(g:buffer_reopen, a:filename)
    if l:index != -1
        call remove(g:buffer_reopen, l:index)
    endif
    call add(g:buffer_reopen, a:filename)
endfunction

augroup myBuffer
    autocmd!
    autocmd BufUnload * call s:UpdateBufferUndo(expand('<afile>:p'))
    autocmd BufLeave * call s:WipeEmptyBuffer()
augroup END

nnoremap <silent> <leader>o :call buffer#Navigate(1)<CR>
nnoremap <silent> <leader>i :call buffer#Navigate(0)<CR>
nnoremap <silent> <leader>` <C-^>

nnoremap <expr><silent> + common#Open(":bn\<CR>")
nnoremap <expr><silent> _ common#Open(":bp\<CR>")
xnoremap <expr><silent> + common#Open(":\<C-u>bn\<CR>")
xnoremap <expr><silent> _ common#Open(":\<C-u>bp\<CR>")

nnoremap <silent> <leader>q :call buffer#Close('bwipeout')<CR>
nnoremap <silent> <leader>Q :call buffer#Close('bdelete')<CR>
nnoremap <silent> <leader>u :call buffer#Reopen()<CR>
