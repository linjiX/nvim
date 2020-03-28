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

let s:large_config = {
            \   '&l:complete': '.',
            \   '&l:foldmethod': 'manual',
            \   '&l:foldenable': 0,
            \   '&l:swapfile': 0,
            \   'b:ale_enabled': 0,
            \   'b:coc_enabled': 0,
            \   'b:matchup_matchparen_enabled': 0,
            \   'b:matchup_matchparen_fallback': 0,
            \}

function large#handle() abort
    let b:large_config = utility#SetConfig(s:large_config)

    let s:eventignore = &eventignore
    set eventignore+=FileType
    autocmd myLargeFile BufEnter <buffer> ++once call s:EnterLargeFile()
endfunction

function large#reset() abort
    if !exists('b:large_config')
        return
    endif
    call utility#SetConfig(b:large_config)
    unlet b:large_config

    filetype detect
endfunction

function s:EnterLargeFile() abort
    call utility#Log('File is too large, trigger large file handling!')
    let &eventignore = s:eventignore
    unlet s:eventignore
endfunction
