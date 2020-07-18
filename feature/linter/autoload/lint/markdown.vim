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

function lint#markdown#GetMarkdownlintCommand(buffer) abort
    let l:options = ale#Var(a:buffer, 'markdown_markdownlint_cli_options')
    return '%e'. ale#Pad(l:options) .' %t'
endfunction

function lint#markdown#HandleMarkdownlintFormat(buffer, lines) abort
    let l:pattern='\v(.{-}):(\d+):?(\d+)? (MD\d{3})/(.{-}) (.{-})( \[Context: .+\])?$'
    let l:output=[]

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
                    \   'lnum': str2nr(l:match[2]),
                    \   'col': str2nr(l:match[3]),
                    \   'type': 'W',
                    \   'code': l:match[4],
                    \   'text': '('. l:match[5] .') '. l:match[6],
                    \   'detail': l:match[1] .':'. l:match[2]
                    \             ."\ntype: W"
                    \             ."\ncode: ". l:match[4]
                    \             ."\nname: ". l:match[5]
                    \             ."\ntext: ". l:match[6].l:match[7]
                    \})
    endfor

    return l:output
endfunction
