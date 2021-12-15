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

        if l:value is v:null && exists(l:key)
            execute printf('unlet %s', l:key)
        elseif type(l:value) == v:t_string
            execute printf('let %s = "%s"', l:key, l:value)
        else
            execute printf('let %s = %s', l:key, l:value)
        endif
    endfor
    return l:old_config
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

let s:script_functions = {}

function s:ScriptSNR(bufname) abort
    redir => l:scriptnames
    silent scriptnames
    redir END

    for l:scriptname in split(l:scriptnames, '\n')
        let [l:snr, l:name] = split(l:scriptname, ': ')
        if l:name =~# a:bufname
            return str2nr(l:snr)
        endif
    endfor
    return -1
endfunction

function utility#ScriptFunction(name, filename) abort
    if has_key(s:script_functions, a:name)
        return s:script_functions[a:name]
    endif
    let l:snr = s:ScriptSNR(a:filename)
    let s:script_functions[a:name] = function(printf('<SNR>%d_%s', l:snr, a:name))
    return s:script_functions[a:name]
endfunction

function utility#SearchIndex() abort
    let l:result = searchcount({'maxcount': 1000})
    if l:result.incomplete == 0
        let l:count = printf('[%d/%d]', l:result.current, l:result.total)
    elseif l:result.incomplete == 1
        let l:count = '[?/??]'
    elseif l:result.total > l:result.maxcount && l:result.current > l:result.maxcount
        let l:count = printf('[>%d/>%d]', l:result.current, l:result.total)
    elseif l:result.total > l:result.maxcount
        let l:count = printf('[%d/>%d]', l:result.current, l:result.total)
    endif
    let l:direction = v:searchforward == 1 ? '/' : '?'
    redraw
    echo l:count . '  ' . l:direction . @/
endfunction
