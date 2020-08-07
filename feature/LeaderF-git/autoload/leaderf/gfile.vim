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

execute g:Lf_py 'from leaderf.devicons import ('.
            \ 'matchaddDevIconsDefault,'.
            \ 'matchaddDevIconsExact,'.
            \ 'matchaddDevIconsExtension,'.
            \ 'webDevIconsGetFileTypeSymbol,'.
            \ ')'

function s:ParserLine(line) abort
    if get(g:, 'Lf_ShowDevIcons', 1)
        let s:offset = 5
    else
        let s:offset = 0
    endif
    return a:line[s:offset :]
endfunction

function leaderf#gfile#Command(args) abort
    let l:cmd = 'git ls-files'
    return leaderf#utility#Command(l:cmd)
endfunction

function leaderf#gfile#GetDevIcon(filename) abort
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
    if !get(g:, 'Lf_ShowDevIcons', 1)
        return a:line
    endif
    let l:devicon = leaderf#gfile#GetDevIcon(a:line)
    return l:devicon . a:line
endfunction

function s:Accept(line) abort
    let l:file = s:ParserLine(a:line)
    execute 'edit ' . l:file
endfunction

function leaderf#gfile#Accept(line, args) abort
    call leaderf#utility#Wrap(function('s:Accept'), a:line)
endfunction

function s:Preview(line) abort
    let l:file = s:ParserLine(a:line)
    let l:bufnr = bufadd(l:file)
    return [l:bufnr, 0, '']
endfunction

function leaderf#gfile#Preview(orig_bufnr, orig_cursor, line, args) abort
    return leaderf#utility#Wrap(function('s:Preview'), a:line)
endfunction

function leaderf#gfile#GetDigestInternal(file, offset, mode) abort
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

function leaderf#gfile#GetDigest(line, mode) abort
    let l:file = s:ParserLine(a:line)
    return leaderf#gfile#GetDigestInternal(l:file, s:offset, a:mode)
endfunction

function leaderf#gfile#AfterEnter(orig_buf_nr, orig_cursor, args) abort
    if !get(g:, 'Lf_ShowDevIcons', 1)
        return
    endif
    execute g:Lf_py 'matchaddDevIconsExtension(r"__icon__")'
    execute g:Lf_py 'matchaddDevIconsExact(r"__icon__")'
    execute g:Lf_py 'matchaddDevIconsDefault(r"__icon__")'
endfunction
