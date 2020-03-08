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

let s:vimFunction = hlID('vimFunction')
let s:vimAugroupKey = hlID('vimAugroupKey')
let s:vimAugroup = hlID('vimAugroup')
let s:vimFuncBody = hlID('vimFuncBody')

function fold#vimscript#Expr() abort
    if exists('b:current_syntax') && b:current_syntax ==# 'vim'
        let l:line = getline(v:lnum)
        let l:col = match(l:line, '^\s*\zs') + 1
        let l:syntax_names = synstack(v:lnum, l:col)

        if index(l:syntax_names, s:vimFunction) != -1
            return 'a1'
        elseif index(l:syntax_names, s:vimAugroupKey) != -1
            return match(l:line, '\<aug\%[roup]\>\s\+[eE][nN][dD]\>') == -1 ? 'a1' : 's1'
        elseif index(l:syntax_names, s:vimAugroup) != -1 ||
                    \ index(l:syntax_names, s:vimFuncBody) != -1
            return '='
        else
            return 's1'
        endif
    endif
endfunction
