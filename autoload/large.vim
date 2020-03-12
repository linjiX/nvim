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

function large#handle() abort
    let b:large_config = {}

    let b:large_config.bufhidden = &l:bufhidden
    " let b:large_config.backup = &l:backup
    " let b:large_config.writebackup = &l:writebackup
    let b:large_config.complete = &l:complete
    let b:large_config.foldmethod = &l:foldmethod
    let b:large_config.foldenable = &l:foldenable
    let b:large_config.swapfile = &l:swapfile
    " let b:large_config.undolevels = &l:undolevels

    let b:large_config.eventignore = &eventignore

    setlocal bufhidden=unload
    " set nobackup
    " set nowritebackup
    setlocal complete-=wbuU
    setlocal foldmethod=manual
    setlocal nofoldenable
    setlocal noswapfile
    " setlocal undolevels=-1

    set eventignore+=FileType
    autocmd myLargeFile BufEnter <buffer> ++once let &eventignore = b:large_config.eventignore

    if exists('g:ale_enabled')
        let b:large_config.ale_enabled = get(b:, 'ale_enabled', g:ale_enabled)
        let b:ale_enabled = 0
    endif
    if exists('g:coc_enabled')
        let b:large_config.coc_enabled = get(b:, 'coc_enabled', g:coc_enabled)
        let b:coc_enabled = 0
    endif
    if exists('g:matchup_matchparen_enabled')
        let b:large_config.matchup_matchparen_enabled =
                    \ get(b:, 'matchup_matchparen_enabled', g:matchup_matchparen_enabled)
        let b:large_config.matchup_matchparen_fallback = get(b:, 'matchup_matchparen_fallback', 1)
        let b:matchup_matchparen_enabled = 0
        let b:matchup_matchparen_fallback = 0
    endif
    let b:formatters_json = ['json_tool']

endfunction

function large#reset() abort
    if !exists('b:large_config')
        return
    endif

    " for [l:key, l:value] in items(b:large_config)
    "     execute 'let &l:'. l:key .' = '. l:value
    " endfor

    let &l:bufhidden = b:large_config.bufhidden
    " let &l:backup = b:large_config.backup
    " let &l:writebackup = b:large_config.writebackup
    let &l:complete = b:large_config.complete
    let &l:foldmethod = b:large_config.foldmethod
    let &l:foldenable = b:large_config.foldenable
    let &l:swapfile = b:large_config.swapfile
    " let &l:undolevels = b:large_config.undolevels

    if exists('g:ale_enabled')
        let b:ale_enabled = b:large_config.ale_enabled
    endif
    if exists('g:coc_enabled')
        let b:coc_enabled = b:large_config.coc_enabled
    endif
    if exists('g:matchup_matchparen_enabled')
        let b:matchup_matchparen_enabled = b:large_config.matchup_matchparen_enabled
        let b:matchup_matchparen_fallback = b:large_config.mmatchup_matchparen_fallback
    endif

    unlet b:large_config
endfunction
