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

function fold#markdown#Expr()
    if &buftype ==# 'terminal'
        return
    endif

    let l:line = getline(v:lnum)
    let l:level = len(matchstr(l:line, '^\zs#\{1,6}\ze\s'))

    if l:level && !s:IsCodeBlock(v:lnum)
        return '>'. l:level
    elseif l:line =~# '\v^\s*$'
        return -1
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
