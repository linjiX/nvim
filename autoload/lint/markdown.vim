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

function lint#markdown#HandleMarkdownlintFormat(buffer, lines) abort
    let l:pattern='\v(.+):(\d+) (MD\d{3})/(.{-}) (.{-})( \[Context: .+\])?$'
    let l:output=[]

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
                    \   'lnum': str2nr(l:match[2]),
                    \   'type': 'W',
                    \   'code': l:match[3],
                    \   'text': '('. l:match[4] .') '. l:match[5],
                    \   'detail': l:match[1] .':'. l:match[2]
                    \             ."\ntype: W"
                    \             ."\ncode: ". l:match[3]
                    \             ."\nname: ". l:match[4]
                    \             ."\ntext: ". l:match[5].l:match[6]
                    \})
    endfor

    return l:output
endfunction
