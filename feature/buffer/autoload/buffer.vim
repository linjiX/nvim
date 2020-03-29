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
            let l:old_index = w:buffer_order.index
            let w:buffer_order.index = l:index
            try
                execute 'buffer '. l:bufnr
            catch /^Vim\%((\a\+)\)\=:E37/
                let w:buffer_order.index = l:old_index
            endtry
            return v:true
        endif

        call remove(w:buffer_order.bufnrs, l:index)
        if a:is_backward
            let l:index -= 1
            let w:buffer_order.index -= 1
        endif
    endwhile

    echo a:is_backward ? 'No backward buffer'
                \      : 'No forward buffer'
    return v:false
endfunction

function s:BPrevious(bufnr) abort
    bprevious
    return a:bufnr != bufnr()
endfunction

function s:CheckModified() abort
    if !&l:modified
        return v:true
    endif

    if !&confirm
        throw 'E89: No write since last change for buffer'. bufname() .'(add ! to override)'
        " call utility#LogError('No write since last change for buffer '. bufname() .
        " \         ' (add ! to override)')
    endif

    let l:options = "&Yes\n&No\n&Cancel"
    let l:choice = confirm('Save Changes in '. bufname() .' before removing it?', l:options, 3)

    if l:choice == 1
        silent w!
    elseif l:choice == 2
        setlocal nomodified
    else
        return v:false
    endif

    return v:true
endfunction

function s:CheckMultiWindow(winids) abort
    if len(a:winids) == 1
        return v:true
    endif

    if !&confirm
        throw 'Buffer '. bufname() .' displayed in multiple windows, command cancelled (add ! to delete anyway)'
    endif

    let l:choice = confirm('Buffer '. bufname() .' displayed in multiple windows, delete it anyway?', "&Yes\n&No", 1)
    if l:choice == 1
        return v:true
    endif

    return v:false
endfunction

function buffer#Close(cmd) abort
    if !s:CheckModified()
        return
    endif

    let l:bufnr = bufnr()
    let l:winids = filter(win_findbuf(l:bufnr), 'v:val != win_getid()') + [win_getid()]

    if !s:CheckMultiWindow(l:winids)
        return
    endif

    for l:winid in l:winids
        noautocmd call win_gotoid(l:winid)
        silent if !(buffer#Navigate(1) || buffer#Navigate(0) || s:BPrevious(l:bufnr))
            Startify
        endif
    endfor

    if bufexists(l:bufnr)
        let l:old_buflisted = &l:buflisted
        let &l:buflisted = 1
        try
            execute a:cmd . l:bufnr
        finally
            let &l:buflisted = l:old_buflisted
        endtry
    endif
endfunction
