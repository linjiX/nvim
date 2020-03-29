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

function s:UpdateBufferHistory(bufnr) abort
    if !exists('w:buffer_history')
        let w:buffer_history = {}
        let w:buffer_history.index = 0
        let w:buffer_history.bufnrs = [a:bufnr]
        return
    endif

    if w:buffer_history.bufnrs[w:buffer_history.index] == a:bufnr
        return
    endif

    let w:buffer_history.bufnrs = w:buffer_history.bufnrs[0 : w:buffer_history.index]

    let l:index = index(w:buffer_history.bufnrs, a:bufnr)
    if l:index != -1
        call remove(w:buffer_history.bufnrs, l:index)
    endif
    call add(w:buffer_history.bufnrs, a:bufnr)

    let w:buffer_history.index = len(w:buffer_history.bufnrs) - 1
endfunction

let g:buffer_reopen = []
function s:UpdateBufferUndo(bufnr) abort
    if !buflisted(a:bufnr)
        return
    endif
    let l:filename = bufname(a:bufnr)

    let l:index = index(g:buffer_reopen, l:filename)
    if l:index != -1
        call remove(g:buffer_reopen, l:index)
    endif
    call add(g:buffer_reopen, l:filename)
endfunction

augroup myBuffer
    autocmd!
    autocmd WinEnter,BufEnter * call s:UpdateBufferHistory(str2nr(expand('<abuf>')))
    autocmd BufDelete,BufWipeout * call s:UpdateBufferUndo(str2nr(expand('<abuf>')))
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
