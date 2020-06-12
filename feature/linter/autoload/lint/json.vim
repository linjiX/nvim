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

function lint#json#GetJsonlintCommand(buffer) abort
    let l:options = ale#Var(a:buffer, 'json_Jsonlint_options')
    return '%e'. ale#Pad(l:options) .' %t'
endfunction

function lint#json#HandleJsonlintFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+): (.{-}): (.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': str2nr(l:match[2]),
                        \   'col': str2nr(l:match[3]),
                        \   'type': l:match[4] is# 'Error' ? 'E'
                        \                                  : l:match[4] is# 'Warning' ? 'W'
                        \                                                             : 'I',
                        \   'text': l:match[5],
                        \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                        \             ."\ntype: ". l:match[4]
                        \             ."\ntext: ". l:match[5],
                        \})
        endif
    endfor

    return l:output
endfunction
