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
    let l:bufnrs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufnrs = filter(l:bufnrs, 'getbufvar(v:val, "&filetype") ==# "coc-explorer"')
    return !empty(l:bufnrs)
endfunction

function s:HasTagbar() abort
    return bufwinnr('__Tagbar__') != -1
endfunction

function s:SetWindowConfig() abort
    let l:tagbar_config = {}
    let l:tagbar_config.tagbar_left = get(g:, 'tagbar_left', 0)
    let l:tagbar_config.tagbar_autofocus = get(g:, 'tagbar_autofocus', 0)
    let l:tagbar_config.tagbar_vertical = get(g:, 'tagbar_vertical', 0)

    let g:tagbar_left = 0
    let g:tagbar_autofocus = 0
    let g:tagbar_vertical = (winheight(0) - 1)/2

    return l:tagbar_config
endfunction

function s:ResetWindowConfig(tagbar_config) abort
    let g:tagbar_left = a:tagbar_config.tagbar_left
    let g:tagbar_autofocus = a:tagbar_config.tagbar_autofocus
    let g:tagbar_vertical = a:tagbar_config.tagbar_vertical
endfunction

function s:GetWinID() abort
    let s:prev_winid = win_getid()
endfunction

function s:GotoWinID() abort
    if !exists('s:prev_winid')
        return
    endif
    noautocmd call win_gotoid(s:prev_winid)
    unlet s:prev_winid
endfunction

function workspace#Disable() abort
    let l:has_explorer = s:HasExplorer()
    if l:has_explorer
        CocCommand explorer --toggle
    endif

    let l:has_tagbar = s:HasTagbar()
    if l:has_tagbar
        TagbarClose
    endif

    return l:has_tagbar || l:has_explorer
endfunction

function workspace#Toggle() abort
    if workspace#Disable()
        return
    endif
    call s:GetWinID()
    call TagbarTrigger()
    execute 'CocCommand explorer --width '. SiderBarWidth()
endfunction

function workspace#Reveal() abort
    if !s:HasTagbar()
        call TagbarTrigger()
    endif
    execute 'CocCommand explorer --no-toggle --width '. SiderBarWidth() .' --reveal='. expand('%:p')
endfunction

function TagbarTrigger() abort
    autocmd myWorkspace BufWinEnter \[coc-explorer\]* ++once
                \ autocmd myWorkspace CursorMoved * ++once call s:OpenTagbar()
endfunction

function s:OpenTagbar() abort
    clearjumps
    let l:line = line('.')
    noautocmd execute '1'

    let l:tagbar_config = s:SetWindowConfig()
    try
        TagbarOpen
    finally
        call s:ResetWindowConfig(l:tagbar_config)

        noautocmd execute l:line
        call s:GotoWinID()
    endtry
endfunction
