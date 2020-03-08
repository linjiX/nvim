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

function fold#vimscript#Expr()
    if exists('b:current_syntax') && b:current_syntax ==# 'vim'
        let l:col = match(getline(v:lnum), '^\s*\zs') + 1
        let l:syntax_names = map(synstack(v:lnum, l:col), 'synIDattr(v:val, "name")')

        if index(l:syntax_names, 'vimFunction') != -1
            return 'a1'
        elseif index(l:syntax_names, 'vimAugroupKey') != -1
            if index(l:syntax_names, 'vimAugroup') != -1
                return 'a1'
            else
                return 's1'
            endif
        elseif index(l:syntax_names, 'vimAugroup') != -1
            return '='
        elseif index(l:syntax_names, 'vimFuncBody') != -1
            return '='
        else
            return 's1'
        endif
    endif
endfunction
