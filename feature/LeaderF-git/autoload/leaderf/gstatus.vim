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

function leaderf#gstatus#Accept(line, args) abort
    let l:file = a:line[s:start :]
    execute 'edit '. l:file
endfunction

function leaderf#gstatus#GetDigest(line, mode)
    let l:file = a:line[s:start :]
    let l:result = leaderf#gfile#GetDigest(l:file, a:mode)
    if empty(l:result[0])
        return l:result
    endif
    let l:result[1] += s:start
    return l:result
endfunction
