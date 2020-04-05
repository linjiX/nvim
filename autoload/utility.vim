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

function s:Log(level, msg) abort
    try
        execute 'echohl '. a:level
        echo a:msg
    finally
        echohl None
    endtry
endfunction

function utility#LogError(msg) abort
    call s:Log('ErrorMsg', a:msg)
endfunction

function utility#LogWarning(msg) abort
    call s:Log('WarningMsg', a:msg)
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

function utility#TerminalList() abort
    if has('nvim')
        let l:bufnrs = map(range(1, winnr('$')), 'winbufnr(v:val)')
        return filter(l:bufnrs, 'getbufvar(v:val, "&buftype") ==# "terminal"')
    else
        return term_list()
    endif
endfunction

function s:GetListedBufWinnrs() abort
    let l:other_winnrs = range(1, winnr() - 1) + range(winnr() + 1, winnr('$'))
    return filter(l:other_winnrs, 'buflisted(winbufnr(v:val))')
endfunction

function utility#Open(cmd) abort
    let l:wincmd = ''
    if &buflisted == 0 && winnr('$') > 1
        let l:winnrs = s:GetListedBufWinnrs()
        if !empty(l:winnrs)
            let l:wincmd = ':'. l:winnrs[0] ."wincmd w\<CR>"
        endif
    endif
    return l:wincmd . a:cmd
endfunction

function utility#Quit(cmd) abort
    if getcmdtype() !=# ':' || trim(getcmdline()) !=# a:cmd
        return a:cmd
    endif
    let l:is_write = a:cmd =~# 'w'
    let l:winnrs = s:GetListedBufWinnrs()
    if empty(l:winnrs)
        return tabpagenr('$') > 1 ? l:is_write ? 'w | tabclose' : 'tabclose'
                    \             : l:is_write ? 'w | qa' : 'qa'
    else
        return l:is_write ? 'wq' : 'q'
    endif
endfunction
