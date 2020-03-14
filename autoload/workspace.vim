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

function s:CheckCocInit()
    if !exists('g:coc_init')
        call utility#Log('COC is not initialized yet!')
        return v:false
    endif
    return v:true
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
    if !s:CheckCocInit()
        return
    endif
    if workspace#Disable()
        return
    endif
    call s:GetWinID()
    call TagbarTrigger()
    execute 'CocCommand explorer --width '. SiderBarWidth()
endfunction

function workspace#Reveal() abort
    if !s:CheckCocInit()
        return
    endif
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

    let l:workspace_config = {
                \   'g:tagbar_left': 0,
                \   'g:tagbar_autofocus': 0,
                \   'g:tagbar_vertical': (winheight(0) - 1)/2,
                \}

    let l:old_config = utility#SetConfig(l:workspace_config)
    try
        TagbarOpen
    finally
        call utility#SetConfig(l:old_config)

        noautocmd execute l:line
        call s:GotoWinID()
    endtry
endfunction
