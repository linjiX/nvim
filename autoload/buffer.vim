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

function s:GetListedBufWinnrs() abort
    let l:other_winnrs = range(1, winnr() - 1) + range(winnr() + 1, winnr('$'))
    return filter(l:other_winnrs, 'buflisted(winbufnr(v:val))')
endfunction

function buffer#Open(cmd) abort
    let l:wincmd = ''
    if &buflisted == 0 && winnr('$') > 1
        let l:winnrs = s:GetListedBufWinnrs()
        if !empty(l:winnrs)
            let l:wincmd = ':'. l:winnrs[0] ."wincmd w\<CR>"
        endif
    endif
    return l:wincmd . a:cmd
endfunction

function buffer#Quit(cmd) abort
    if getcmdtype() !=# ':' || trim(getcmdline()) !=# a:cmd
        return a:cmd
    endif
    let l:is_write = a:cmd =~# 'w'
    let l:winnrs = s:GetListedBufWinnrs()
    if empty(l:winnrs)
        return tabpagenr('$') > 1 ? l:is_write ? 'w | tabclose' : 'tabclose'
                    \             : l:is_write ? 'w | qa' : 'qa'
    else
        return l:is_write ? 'wq' : 'q'
    endif
endfunction

function buffer#Navigate(is_backward) abort
    let l:index = a:is_backward ? w:buffer_order.index - 1
                \               : w:buffer_order.index + 1

    while l:index >= 0 && l:index < len(w:buffer_order.bufnrs)
        let l:bufnr = w:buffer_order.bufnrs[l:index]

        if buflisted(l:bufnr)
            let w:buffer_order.index = l:index
            execute 'buffer '. l:bufnr
            return
        endif

        call remove(w:buffer_order.bufnrs, l:index)
        if a:is_backward
            let l:index -= 1
        endif
    endwhile

    echo a:is_backward ? 'No backward buffer'
                \      : 'No forward buffer'
endfunction
