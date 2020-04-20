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
    let l:choice = confirm(l:msg, "&Yes\n&Cancel", 2)
    if l:choice == 1
        return v:true
    endif

    return v:false
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


function s:BPrevious() abort
    let l:bufnr = bufnr()
    bprevious
    return l:bufnr != bufnr()
endfunction

function s:JumpCount(is_older, lambda) abort
    let [l:jumplist, l:position] = getjumplist()

    try
        let l:range = a:is_older ? range(l:position - 1, 0, -1)
                    \            : range(l:position + 1, len(l:jumplist) - 1)
    catch /^Vim\%((\a\+)\)\=:E727/
        let l:range = []
    endtry

    let l:normal_count = v:count1
    let l:count = 0

    for l:index in l:range
        let l:count += 1
        if a:lambda(l:jumplist[l:index].bufnr)
            let l:normal_count -= 1
            if l:normal_count == 0
                return l:count
            endif
        endif
    endfor
    return 0
endfunction

function buffer#Jump(is_older) abort
    let l:Lambda = buflisted(bufnr()) ? {bufnr -> buflisted(bufnr)}
                \                     : {bufnr -> !buflisted(bufnr)}
    let l:count = s:JumpCount(a:is_older, l:Lambda)
    if l:count
        execute 'normal! '. l:count . (a:is_older ? "\<C-o>" : "\<C-i>")
    else
        echo a:is_older ? 'No older jump'
                    \   : 'No newer jump'
    endif
endfunction

function buffer#Navigate(is_older) abort
    let l:current_bufnr = bufnr()
    let l:count = s:JumpCount(a:is_older,
                \             {bufnr -> bufnr != l:current_bufnr && buflisted(bufnr)})
    if l:count
        execute 'normal! '. l:count . (a:is_older ? "\<C-o>" : "\<C-i>")
        if bufnr() == l:current_bufnr
            throw 'Buffer not change after navigate'
        endif
        return v:true
    else
        echo a:is_older ? 'No older buffer'
                    \   : 'No newer buffer'
        return v:false
    endif
endfunction

function buffer#Close(cmd) abort
    let l:bufnr = bufnr()
    let l:winids = filter(win_findbuf(l:bufnr), 'v:val != win_getid()') + [win_getid()]

    if !s:CheckMultiWindow(l:winids) || !s:CheckModified()
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

let s:switch_regex = '\v\C\/\zs(plugin|autoload)\ze\/\w*\.vim'
let s:switch = {'plugin': 'autoload', 'autoload': 'plugin'}

function buffer#Switch() abort
    let l:bufname = expand('%:p')
    let l:switch_bufname = substitute(l:bufname, s:switch_regex, '\=s:switch[submatch(1)]', '')

    if l:switch_bufname == l:bufname || !filereadable(l:switch_bufname)
        echo 'No switch file'
        return
    endif

    execute 'edit '. l:switch_bufname
endfunction
