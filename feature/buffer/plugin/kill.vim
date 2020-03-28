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

function s:UpdateBufferList() abort
    if !exists('w:buffer_order')
        let w:buffer_order = {}
        let w:buffer_order.index = v:null
        let w:buffer_order.bufnrs = []
    endif
    let l:bufnr = bufnr()

    if !empty(w:buffer_order.bufnrs) && w:buffer_order.bufnrs[w:buffer_order.index] == l:bufnr
        return
    endif

    let w:buffer_order.bufnrs = w:buffer_order.bufnrs[0 : w:buffer_order.index]

    let l:index = index(w:buffer_order.bufnrs, l:bufnr)
    if l:index != -1
        call remove(w:buffer_order.bufnrs, l:index)
    endif
    call add(w:buffer_order.bufnrs, l:bufnr)

    let w:buffer_order.index = len(w:buffer_order.bufnrs) - 1
endfunction

augroup myBuffer
    autocmd!
    autocmd BufEnter * call s:UpdateBufferList()
augroup END

nnoremap <silent> <leader>o :call buffer#Navigate(1)<CR>
nnoremap <silent> <leader>i :call buffer#Navigate(0)<CR>
