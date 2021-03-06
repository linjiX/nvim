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

function fold#Text()
    let l:line = s:GetText(v:foldstart, v:foldend) .' '
    let l:info = printf('--- lines:%3d', v:foldend - v:foldstart + 1)

    let l:colorcolumn = empty(&l:colorcolumn) ? 100 : &l:colorcolumn
    let l:text_width = l:colorcolumn - len(l:info) - 1
    let l:space = l:text_width - len(l:line)
    if l:space > 0
        let l:text = l:line . repeat('-', l:space)
    else
        let l:text = l:line[: l:space - 3] .'… '
    endif

    return l:text . l:info
endfunction

function s:GetText(foldstart, foldend) abort
    let l:line = getline(a:foldstart)

    if &l:foldmethod ==# 'marker'
        let [l:start_marker, l:end_marker] = split(&l:foldmarker, ',')
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
    elseif &l:foldmethod ==# 'syntax'
        if &l:filetype ==# 'json'
            let [l:pair_start, l:start, l:end] =
                        \ matchstrpos(l:line, '\v^%([^"]|"%([^"]|\")*"){-}\zs[{[]')
            let l:pair_end = l:pair_start ==# '[' ? ']' : '}'

            let l:endline = getline(a:foldend)
            let l:comma = matchstr(l:endline, l:pair_end .'\s\{-}\zs,\ze.\{-}$')

            let l:text = l:line[: l:start] .'…'. l:pair_end . l:comma
            return l:text
        endif
    endif

    return substitute(l:line, '	', repeat(' ', &l:tabstop), 'g')
endfunction

scriptencoding utf-8
