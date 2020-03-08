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
scriptencoding utf-8

function fold#Text()
    let l:line = s:GetText(v:foldstart) .' '
    let l:info = printf('--- lines:%3d', v:foldend - v:foldstart + 1)

    let l:text_width = &colorcolumn - len(l:info) - 1
    let l:space = l:text_width - len(l:line)
    if l:space > 0
        let l:text = l:line . repeat('-', l:space)
    else
        let l:text = l:line[: l:space - 3] .'… '
    endif

    return l:text . l:info
endfunction

function s:GetText(foldstart) abort
    let l:line = getline(a:foldstart)

    if &foldmethod ==# 'marker'
        let [l:start_marker, l:end_marker] = split(&foldmarker, ',')
        let l:regex = '"\?\s*'. l:start_marker .'\d*\s*$'
        let l:text = substitute(l:line, l:regex, '' , '')
        if match(l:text, '^\s*$') != -1
            let l:next_line = getline(a:foldstart + 1)
            if match(l:next_line, l:start_marker . '\|' . l:end_marker) != -1
                return l:line
            else
                return l:next_line
            endif
        endif
        return l:text
    endif

    return l:line
endfunction
