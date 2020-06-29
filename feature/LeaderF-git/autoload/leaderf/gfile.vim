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

function leaderf#gfile#Accept(line, args) abort
    execute 'edit '. a:line
endfunction

function leaderf#gfile#GetDigest(line, mode)
    if a:mode == 0
        return [a:line, 0]
    elseif a:mode == 1
        let l:idx = strridx(a:line, '/') + 1
        return [a:line[l:idx :], l:idx]
    else
        let l:idx = strridx(a:line, '/')
        if l:idx == -1
            return ['', 0]
        endif
        return [a:line[: l:idx], 0]
    endif
endfunction
