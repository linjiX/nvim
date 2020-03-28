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
