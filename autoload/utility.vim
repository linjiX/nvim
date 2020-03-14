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

function utility#Log(msg) abort
    try
        echohl WarningMsg
        echo a:msg
    finally
        echohl None
    endtry
endfunction

function utility#SetConfig(config) abort
    let l:old_config = {}
    for [l:key, l:value] in items(a:config)
        let l:old_value = exists(l:key) ? eval(l:key) : v:null
        let l:old_config[l:key] = l:old_value

        if l:value is v:null
            execute printf('unlet %s', l:key)
        elseif type(l:value) == v:t_string
            execute printf('let %s = "%s"', l:key, l:value)
        else
            execute printf('let %s = %s', l:key, l:value)
        endif
    endfor
    return l:old_config
endfunction
