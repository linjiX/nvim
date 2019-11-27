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

function s:HasDefx() abort
    let l:bufs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufs = filter(l:bufs, 'getbufvar(v:val, "&filetype") ==# "defx"')
    return len(l:bufs) >= 1
endfunction

function s:HasTagbar() abort
    return bufwinnr('__Tagbar__') != -1
endfunction

function s:SetWindowConfig() abort
    if exists('g:tagbar_left')
        let s:tagbar_left_user = g:tagbar_left
    endif
    if exists('g:tagbar_vertical')
        let s:tagbar_vertical_user = g:tagbar_vertical
    endif

    let g:tagbar_left = 0
    let g:tagbar_vertical = winheight(0)/2

    let s:prev_winid = win_getid()
endfunction

function s:ResetWindowConfig() abort
    if exists('s:tagbar_left_user')
        let g:tagbar_left = s:tagbar_left_user
        unlet s:tagbar_left_user
    else
        unlet g:tagbar_left
    endif
    if exists('s:tagbar_vertical_user')
        let g:tagbar_vertical = s:tagbar_vertical_user
        unlet s:tagbar_vertical_user
    else
        unlet g:tagbar_vertical
    endif

    call win_gotoid(s:prev_winid)

    unlet s:prev_winid
endfunction

function defx_tagbar#ToggleDefxTagbar() abort
    let l:has_defx = s:HasDefx()
    let l:has_tagbar = s:HasTagbar()

    if l:has_defx
        Defx -toggle
    endif

    if l:has_tagbar
        TagbarClose
    endif

    if l:has_defx && l:has_tagbar
        return
    endif

    call s:SetWindowConfig()

    Defx -split='vertical' -direction='topleft' -winwidth=`SiderBarWidth()`
    setlocal nowinfixheight
    setlocal winfixwidth

    TagbarOpen

    call s:ResetWindowConfig()
endfunction
