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

let s:start = 3

function gstatus#Accept(line, args) abort
    let l:file = a:line[s:start :]
    execute 'edit '. l:file
endfunction

function gstatus#GetDigest(line, mode)
    let l:file = a:line[s:start :]
    if a:mode == 0
        return [l:file, s:start]
    elseif a:mode == 1
        let l:idx = strridx(l:file, '/') + 1
        return [l:file[l:idx :], l:idx + s:start]
    else
        let l:idx = strridx(l:file, '/')
        if l:idx == -1
            return ['', 0]
        endif
        return [l:file[: l:idx], s:start]
    endif
endfunction
