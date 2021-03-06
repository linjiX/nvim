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

function fold#vimscript#Expr() abort
    if &buftype ==# 'terminal'
        return
    endif

    let l:line = getline(v:lnum)

    if l:line !~# '\v^\s*[aef]'
        return '='
    endif

    if l:line =~# '\v^\s*<%(endf>|endfu%[nction]>|aug%[roup]>\s+[eE][nN][dD])'
        return 's1'
    elseif l:line =~# '\v^\s*<%(fu%[nction]|aug%[roup]>\s+\K\k*)'
        return 'a1'
    else
        return '='
    endif
endfunction
