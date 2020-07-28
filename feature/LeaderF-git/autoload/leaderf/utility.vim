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
function leaderf#utility#Command(cmd) abort
    let s:cwd = leaderf#utility#GetWorkDirectory()
    return 'cd ' . s:cwd . ' && ' . a:cmd
endfunction

function leaderf#utility#Wrap(lambda, args) abort
    execute 'cd ' . s:cwd
    try
        return a:lambda(a:args)
    finally
        cd -
    endtry
endfunction

function leaderf#utility#GetWorkDirectory() abort
    if isdirectory(g:Lf_WorkingDirectory)
        return g:Lf_WorkingDirectory
    endif

    let l:pwd = getcwd()
    let l:dir = expand('%:p:h')
    if stridx(g:Lf_WorkingDirectoryMode, 'a') != -1
        let l:path = l:pwd
    elseif stridx(g:Lf_WorkingDirectoryMode, 'A') != -1
        let l:path = l:dir
    endif

    if exists('l:path')
        let l:cwd = s:NearestAncestor(g:Lf_RootMarkers, l:path)
        if !empty(l:cwd)
            return l:cwd
        endif
    endif

    if stridx(g:Lf_WorkingDirectoryMode, 'f') != -1
        return l:dir
    endif

    if stridx(g:Lf_WorkingDirectoryMode, 'F') != -1
        if stridx(l:dir, l:pwd) == -1
            return l:dir
        endif
    endif
    return l:pwd
endfunction

function s:NearestAncestor(markers, path) abort
    let l:dir = ''
    let l:dir_next = fnamemodify(a:path, ':p')
    while l:dir !=# l:dir_next
        let l:dir = l:dir_next
        for l:marker in a:markers
            if !empty(glob(l:dir . '/' . l:marker))
                return l:dir
            endif
        endfor
        let l:dir_next = fnamemodify(l:dir, ':h')
    endwhile
    return ''
endfunction
