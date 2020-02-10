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

function lint#bzl#GetBuildifierCommand(buffer) abort
    let l:options = ale#Var(a:buffer, 'bzl_buildifier_options')
    return '%e --lint=warn --format=json --mode=check'. ale#Pad(l:options) .' %t'
endfunction

function lint#bzl#HandleBuildifierFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+): (.+)$'
    let l:output = []
    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': l:match[2],
                        \   'col': l:match[3],
                        \   'type': 'E',
                        \   'code': '~',
                        \   'text': l:match[4],
                        \   'detail': l:match[1]
                        \             .':'. l:match[2]
                        \             .':'. l:match[3]
                        \             ."\ntext: ". l:match[4]
                        \})
        endif
    endfor
    if !empty(l:output)
        return l:output
    endif

    let l:json = json_decode(a:lines[0])
    if l:json['success']
        return []
    endif

    for l:file in l:json['files']
        for l:warning in l:file['warnings']
            if ale#path#IsBufferPath(a:buffer, l:file['filename'])
                call add(l:output, {
                            \   'lnum': l:warning['start']['line'],
                            \   'end_lnum': l:warning['end']['line'],
                            \   'col': l:warning['start']['column'],
                            \   'end_col': l:warning['end']['column'],
                            \   'type': 'W',
                            \   'code': l:warning['category'],
                            \   'text': l:warning['message'],
                            \   'detail': l:file['filename']
                            \             .':'. l:warning['start']['line']
                            \             .':'. l:warning['start']['column']
                            \             .' -> '. l:warning['end']['line']
                            \             .':'. l:warning['end']['column']
                            \             ."\ncode: ". l:warning['category']
                            \             ."\ntext: ". l:warning['message']
                            \             ."\nurl: ". l:warning['url'],
                            \})
            endif
        endfor
    endfor

    return l:output
endfunction
