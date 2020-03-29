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
    let [l:jumplist, l:index] = getjumplist()
    let l:len = len(l:jumplist)
    let l:bufnr = bufnr()
    let l:count = 0

    while v:true
        let l:index = a:is_backward ? l:index - 1
                    \               : l:index + 1
        if l:index < 0 || l:index >= l:len
            echo a:is_backward ? 'No backward buffer'
                        \      : 'No forward buffer'
            return v:false
        endif

        let l:item = l:jumplist[l:index]
        if !bufexists(l:item.bufnr)
            continue
        endif

        let l:count += 1
        if buflisted(l:item.bufnr) && l:item.bufnr != l:bufnr
            let l:cmd = a:is_backward ? "\<C-o>"
                        \             : "\<C-i>"
            execute 'normal! '. l:count . l:cmd
            return v:true
        endif
    endwhile
endfunction

function s:BPrevious() abort
    let l:bufnr = bufnr()
    bprevious
    return l:bufnr != bufnr()
endfunction

function s:CheckModified() abort
    if !&l:modified
        return v:true
    endif

    if !&confirm
        let l:msg = 'No write since last change for buffer "'. bufname() .'" (add ! to override)'
        call utility#LogError(l:msg)
        return v:false
    endif

    let l:msg = 'Save Changes in "'. bufname() .'" before removing it?'
    let l:choice = confirm(l:msg, "&Yes\n&No\n&Cancel", 3)

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
        let l:msg = 'Buffer "'. bufname() .'" displayed in multiple windows (add ! to force delete)'
        call utility#LogError(l:msg)
        return v:false
    endif

    let l:msg = 'Buffer "'. bufname() .'" displayed in multiple windows, delete it anyway?'
    let l:choice = confirm(l:msg, "&Yes\n&No", 2)
    if l:choice == 1
        return v:true
    endif

    return v:false
endfunction

function buffer#Close(cmd) abort
    let l:bufnr = bufnr()
    let l:winids = filter(win_findbuf(l:bufnr), 'v:val != win_getid()') + [win_getid()]

    if !s:CheckMultiWindow(l:winids)
        return
    endif
    if !s:CheckModified()
        return
    endif

    for l:winid in l:winids
        noautocmd call win_gotoid(l:winid)
        silent if !(buffer#Navigate(1) || buffer#Navigate(0) || s:BPrevious())
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

function buffer#Reopen() abort
    while !empty(g:buffer_reopen)
        let l:filename = g:buffer_reopen[-1]
        call remove(g:buffer_reopen, -1)

        if !buflisted(l:filename)
            execute 'edit '. l:filename
            return
        endif
    endwhile
    echo 'No reopen buffer'
endfunction
