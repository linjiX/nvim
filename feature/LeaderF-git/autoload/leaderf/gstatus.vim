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

let s:offset = 8
function s:ParserLine(line) abort
    return a:line[s:offset :]
endfunction

function leaderf#gstatus#FormatLine(line, args) abort
    let l:offset = 3
    let l:file = a:line[l:offset :]
    let l:devicon = leaderf#gfile#GetDevIcon(l:file)
    return a:line[: l:offset - 1] . '  ' . l:devicon . l:file
endfunction

function leaderf#gstatus#Accept(line, args) abort
    let l:file = s:ParserLine(a:line)
    execute 'edit '. l:file
endfunction

function leaderf#gstatus#Preview(orig_bufnr, orig_cursor, line, args) abort
    let l:file = s:ParserLine(a:line)
    let bufnr = bufadd(l:file)
    return [bufnr, 0, '']
endfunction

function leaderf#gstatus#GetDigest(line, mode)
    let l:file = s:ParserLine(a:line)
    return leaderf#gfile#GetDigestInternal(l:file, s:offset, a:mode)
endfunction
