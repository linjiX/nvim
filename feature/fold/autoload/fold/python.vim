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

function fold#python#Expr() abort
    let l:line = getline(v:lnum)

    if l:line =~# '\v^\s*%(\@\w*)?$'
        return -1
    elseif l:line !~# '\v^\s*[cda]'
        return '='
    endif

    if l:line =~# '\v^\s*%(class|%(async\s+)?def)\s'
        return '>'. (indent(v:lnum) / &softtabstop + 1)
    else
        return '='
    endif
endfunction
