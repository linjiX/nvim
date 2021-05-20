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

let g:buffer_reopen_ignore_filetype = ['gitcommit']
let g:buffer_local_jump_filetype = ['gitcommit', 'help']
let g:buffer_reopen = []

function s:UpdateBufferUndo() abort
    let l:filename = expand('<afile>:p')
    if !filereadable(l:filename)
        return
    endif

    let l:bufnr = str2nr(expand('<abuf>'))

    if !buflisted(l:bufnr)
        return
    endif

    let l:filetype = getbufvar(l:bufnr, '&filetype')
    if index(g:buffer_reopen_ignore_filetype, l:filetype) != -1
        return
    endif

    let l:index = index(g:buffer_reopen, l:filename)
    if l:index != -1
        call remove(g:buffer_reopen, l:index)
    endif
    call add(g:buffer_reopen, l:filename)
endfunction

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

augroup myBuffer
    autocmd!
    autocmd BufLeave * call s:WipeEmptyBuffer()
    autocmd BufUnload * call s:UpdateBufferUndo()
    " keep <Tab> works in coc-list
    autocmd FileType list nnoremap <C-i> <C-i>
augroup END

nnoremap <silent> <C-o> :<C-u>call buffer#Jump(1)<CR>
nnoremap <silent> <C-i> :<C-u>call buffer#Jump(0)<CR>

nnoremap <silent> <leader>o :<C-u>call buffer#Navigate(1)<CR>
nnoremap <silent> <leader>i :<C-u>call buffer#Navigate(0)<CR>
nnoremap <silent> <leader>` <C-^>

if has('nvim') || has('gui_running')
    nnoremap <expr><silent> <M-]> utility#Open(":bn\<CR>")
    nnoremap <expr><silent> <M-[> utility#Open(":bp\<CR>")
    xnoremap <expr><silent> <M-]> utility#Open(":\<C-u>bn\<CR>")
    xnoremap <expr><silent> <M-[> utility#Open(":\<C-u>bp\<CR>")
else
    nnoremap <expr><silent> <ESC>] utility#Open(":bn\<CR>")
    nnoremap <expr><silent> <ESC>[ utility#Open(":bp\<CR>")
    xnoremap <expr><silent> <ESC>] utility#Open(":\<C-u>bn\<CR>")
    xnoremap <expr><silent> <ESC>[ utility#Open(":\<C-u>bp\<CR>")
    nnoremap <silent><nowait> <ESC> <ESC>
    xnoremap <silent><nowait> <ESC> <ESC>
endif

nnoremap <silent> <leader>q :<C-u>call buffer#Close('bwipeout')<CR>
nnoremap <silent> <leader>Q :<C-u>call buffer#Close('bdelete')<CR>
nnoremap <silent> <leader>u :<C-u>call buffer#Reopen()<CR>
