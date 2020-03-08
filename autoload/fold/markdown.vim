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

function fold#markdown#Expr()
    let l:thisline = getline(v:lnum)
    let l:thislevel = len(matchstr(l:thisline, '^#\{1,6}'))

    if l:thislevel && !s:IsCodeBlock(v:lnum)
        return '>'. l:thislevel
    else
        return '='
    endif
endfunction

function s:IsCodeBlock(lnum)
    if exists('b:current_syntax') && b:current_syntax ==# 'mkd'
        let l:syntax_names = map(synstack(a:lnum, 1), 'synIDattr(v:val, "name")')
        for l:name in l:syntax_names
            if l:name =~# 'Snippet'
                return 1
            endif
        endfor
        return 0
    endif

    let l:curpos = getcurpos()
    try
        call cursor(a:lnum, 1)
        return searchpair('\%^```\|^\n\zs```', '', '```\n^$', 'W')
    finally
        call setpos('.', l:curpos)
    endtry
endfunction
