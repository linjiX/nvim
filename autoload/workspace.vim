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

call plug#load('tagbar')

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
    autocmd! myWorkspace
    if !exists('g:coc_init')
        autocmd myWorkspace User CocNvimInit ++once call workspace#Toggle()
        return
    endif
    if workspace#Disable()
        return
    endif
    call s:GetWinID()
    autocmd myWorkspace User CocExplorerOpenPre ++once call s:OpenTagbar()
    execute 'CocCommand explorer --width '. SiderBarWidth()
endfunction

function workspace#Reveal() abort
    autocmd! myWorkspace
    if !exists('g:coc_init')
        autocmd myWorkspace User CocNvimInit ++once call workspace#Reveal()
        return
    endif

    let l:has_explorer = s:HasExplorer()

    if !l:has_explorer
        if s:HasTagbar()
            TagbarClose
        endif
        autocmd myWorkspace User CocExplorerOpenPre ++once call s:OpenTagbar()
    else
        autocmd myWorkspace BufEnter \[coc-explorer\]-* ++once
                    \ call CocAction('runCommand',
                    \                'explorer.doAction',
                    \                0,
                    \                ['reveal'],
                    \                [['relative', 0, 'file']])
    endif
    execute 'CocCommand explorer --no-toggle'
                \             .' --width '. SiderBarWidth()
                \             .' --reveal '. fnameescape(expand('%:p'))
endfunction

function s:OpenTagbar() abort
    let l:line = line('.')
    noautocmd 1

    let l:workspace_config = {
                \   '&l:cursorline': 0,
                \   'g:tagbar_position': 'rightbelow',
                \   'g:tagbar_autofocus': 0,
                \   'g:tagbar_height': (winheight(0) - 1)/2,
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
