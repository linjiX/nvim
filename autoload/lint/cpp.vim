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

function lint#cpp#HandleCppCheckFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+) (.+):(.+):(.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': str2nr(l:match[2]),
                        \   'col': str2nr(l:match[3]),
                        \   'type': l:match[4] is# 'error' ? 'E' : 'W',
                        \   'code': l:match[5],
                        \   'text': l:match[6],
                        \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                        \             ."\ntype: ". l:match[4]
                        \             ."\ncode: ". l:match[5]
                        \             ."\ntext: ". l:match[6],
                        \})
        endif
    endfor

    let l:pattern_location = '\v^(.+):(\d+):(\d+) (.+)$'
    for l:match in ale#util#GetMatches(a:lines, l:pattern_location)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            let l:lnum = str2nr(l:match[2])
            let l:flag = 1
            for l:item in l:output
                if l:lnum == l:item['lnum'] && l:item['type'] !=# 'I'
                    let l:flag = 0
                    break
                endif
            endfor
            if l:flag == 1
                call add(l:output, {
                            \   'lnum': l:lnum,
                            \   'col': str2nr(l:match[3]),
                            \   'type': 'I',
                            \   'code': '~',
                            \   'text': l:match[4],
                            \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                            \             ."\ntext: ". l:match[4],
                            \})
            endif
        endif
    endfor

    return l:output
endfunction
