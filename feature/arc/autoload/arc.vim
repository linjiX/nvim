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

function arc#Browse(args) abort
    if empty(a:args)
        let l:args = bufname()
    else
        let l:args = a:args
    endif
    call system('arc browse -- ' . l:args)
endfunction

function s:HomepageForUrl(url) abort
    let l:host_pattern = 'phabricator.*'
    let l:hosts = get(g:, 'phabricator_hosts', [])
    call map(copy(l:hosts), 'substitute(v:val, "/$", "", "")')
    for l:host in l:hosts
        let l:host_pattern .= '\|' . escape(split(l:host, '://')[-1], '.')
    endfor

    let l:base_pattern =
                \ '^\%(https\=://\|git://\|git@\|ssh://code@\|ssh://git@\)\=\zs\('.
                \ l:host_pattern .
                \ '\)\/diffusion[/:][^/]\{-\}\ze[/:].\{-\}\%(\.git\)\=$'

    let l:base = matchstr(a:url, l:base_pattern)
    if !empty(l:base)
        let l:base = substitute(l:base, ':\d\{4}', '', '')
        return 'https://' . tr(l:base, ':', '/')
    endif
    return ''
endfunction

function arc#FugitiveUrl(...) abort
    if a:0 == 1 || type(a:1) == v:t_dict
        let l:opts = a:1
        let l:root = s:HomepageForUrl(get(l:opts, 'remote', ''))
    else
        return ''
    endif
    if empty(l:root)
        return ''
    endif
    let l:path = substitute(l:opts.path, '^/', '', '')
    if l:path =~# '^\.git/refs/heads/'
        return l:root . '/history/' . l:path[16:-1]
    elseif l:path =~# '^\.git/refs/tags/'
        return l:root . '/history/;' . l:path[15:-1]
    elseif l:path =~# '^\.git\>'
        return l:root
    endif
    let l:branch = substitute(FugitiveHead(), '/', '%252F7', 'g')
    if empty(l:branch)
        let l:branch = 'master'
    endif
    let l:commit = l:opts.commit
    if l:commit =~# '^\d\=$'
        return ''
    endif
    if get(l:opts, 'type', '') ==# 'tree' || l:opts.path =~# '/$'
        let l:url = substitute(l:root . '/browse/' . l:branch . '/' . l:path, '/$', '', '')
    elseif get(l:opts, 'type', '') ==# 'blob' || l:opts.path =~# '[^/]$'
        let l:url = l:root . '/browse/' . l:branch . '/' . l:path . ';' . l:commit
        if get(l:opts, 'line2') && l:opts.line1 == l:opts.line2
            let l:url .= '$' . l:opts.line1
        elseif get(l:opts, 'line2')
            let l:url .= '$' . l:opts.line1 . '-' . l:opts.line2
        endif
    else
        let l:url = substitute(l:root, '/diffusion/', '/R', '') . ':' . l:commit
    endif
    return l:url
endfunction
