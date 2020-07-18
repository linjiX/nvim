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

execute g:Lf_py 'from leaderf.devicons import webDevIconsGetFileTypeSymbol'

let s:offset = 5
function s:ParserLine(line) abort
    return a:line[s:offset :]
endfunction

function! leaderf#gfile#GetDevIcon(filename) abort
    let l:python_cmd = printf('webDevIconsGetFileTypeSymbol("%s")', a:filename)
    if g:Lf_PythonVersion == 3
        return py3eval(l:python_cmd)
    elseif g:Lf_PythonVersion == 2
        return pyeval(l:python_cmd)
    else
        throw 'Unknown "g:Lf_PythonVersion"!'
    endif
endfunction

function leaderf#gfile#FormatLine(line, args) abort
    let l:devicon = leaderf#gfile#GetDevIcon(a:line)
    return l:devicon . a:line
endfunction

function leaderf#gfile#Accept(line, args) abort
    let l:file = s:ParserLine(a:line)
    execute 'edit '. l:file
endfunction

function leaderf#gfile#Preview(orig_bufnr, orig_cursor, line, args) abort
    let l:file = s:ParserLine(a:line)
    let bufnr = bufadd(l:file)
    return [bufnr, 0, '']
endfunction

function leaderf#gfile#GetDigestInternal(file, offset, mode)
    if a:mode == 0
        return [a:file, a:offset]
    elseif a:mode == 1
        let l:idx = strridx(a:file, '/') + 1
        return [a:file[l:idx :], l:idx + a:offset]
    else
        let l:idx = strridx(a:file, '/')
        if l:idx == -1
            return ['', 0]
        endif
        return [a:file[: l:idx], a:offset]
    endif
endfunction

function leaderf#gfile#GetDigest(line, mode)
    let l:file = s:ParserLine(a:line)
    return leaderf#gfile#GetDigestInternal(l:file, s:offset, a:mode)
endfunction
