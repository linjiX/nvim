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

augroup myWorkspace
    autocmd!
augroup END

function s:HasExplorer() abort
    let l:bufs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufs = filter(l:bufs, 'getbufvar(v:val, "&filetype") ==# "coc-explorer"')
    return len(l:bufs) >= 1
endfunction

function s:HasTagbar() abort
    return bufwinnr('__Tagbar__') != -1
endfunction

function s:SetWindowConfig() abort
    if exists('g:tagbar_left')
        let s:tagbar_left_user = g:tagbar_left
    endif

    let s:tagbar_vertical_user = exists('g:tagbar_vertical') ? g:tagbar_vertical : 0

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

    let g:tagbar_vertical = s:tagbar_vertical_user
    unlet s:tagbar_vertical_user

    call win_gotoid(s:prev_winid)

    unlet s:prev_winid
endfunction

function workspace#ToggleWorkspace() abort
    let l:has_tagbar = s:HasTagbar()
    let l:has_explorer = s:HasExplorer()

    if l:has_tagbar
        TagbarClose
    endif

    if l:has_explorer
        CocCommand explorer --toggle
    endif

    if l:has_tagbar || l:has_explorer
        return
    endif

    call s:SetWindowConfig()

    autocmd myWorkspace BufWinEnter \[coc-explorer\]* ++once call s:OpenTagbarPre()
    CocCommand explorer
endfunction

function s:OpenTagbarPre() abort
    autocmd myWorkspace CursorMoved * ++once call s:OpenTagbar()
endfunction

function s:OpenTagbar() abort
    setlocal nowinfixheight
    setlocal winfixwidth
    TagbarOpen
    call s:ResetWindowConfig()
endfunction
