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

if has('nvim')
    function terminal#GetJobID(bufnr) abort
        return getbufvar(a:bufnr, 'terminal_job_id')
    endfunction

    function terminal#AutoCmdTermClose() abort
        setlocal bufhidden=wipe
        if bufwinid(str2nr(expand('<abuf>'))) != -1
            quit
        endif
    endfunction

    function terminal#AutoCmdInsert() abort
        if !exists('g:insert_skip') && exists('b:terminal_navigate')
            unlet b:terminal_navigate
            startinsert
        endif
    endfunction

    let s:ESC = "\<C-\>\<C-n>" . ":let b:terminal_navigate = 1\<CR>"
    let s:INSERT_PRE = ":let g:insert_skip = 1\<CR>"
    let s:INSERT_POST = ":unlet g:insert_skip\<CR>" . ":call terminal#AutoCmdInsert()\<CR>"
else
    let s:ESC = "\<C-v>"
    let s:INSERT_PRE = ''
    let s:INSERT_POST = ''
endif

function terminal#Detach() abort
    return s:ESC . ":quit\<CR>"
endfunction

function terminal#DetachBash() abort
    if terminal#PS(bufnr()).cmd ==# 'bash'
        return terminal#Detach()
    endif
    return "\<C-d>"
endfunction

function terminal#Navigate(direction) abort
    if terminal#PS(bufnr()).cmd ==# 'fzf'
        if a:direction ==# 'j'
            return "\<C-j>"
        elseif a:direction ==# 'k'
            return "\<C-k>"
        endif
    endif
    return s:ESC . s:INSERT_PRE . NavigateCmd(a:direction) . s:INSERT_POST
endfunction

function terminal#AutoCmdTermOpen() abort
    setlocal nonumber
    setlocal nobuflisted

    if has('nvim')
        startinsert
    endif
endfunction

function s:IsTerminal(bufnr) abort
    if getbufvar(a:bufnr, '&buftype') !=# 'terminal'
        return v:false
    endif

    if has('nvim')
        return jobwait([terminal#GetJobID(a:bufnr)], 0)[0] == -1
    else
        return term_getstatus(a:bufnr) =~# 'running'
    endif
endfunction

function terminal#ActiveList() abort
    let l:bufnrs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    return filter(l:bufnrs, {index, value -> s:IsTerminal(value)})
endfunction

function s:Create(is_vertical, cmd) abort
    if has('nvim')
        let l:precmd = a:is_vertical ? 'botright vsplit ' : 'belowright split '
        let l:postcmd = 'term://'. a:cmd
    else
        let l:precmd = a:is_vertical ? 'vertical botright ' : 'belowright '
        let l:postcmd = 'terminal ++close ++kill=kill '. a:cmd
    endif

    execute l:precmd . l:postcmd
endfunction

function s:Reuse(is_vertical, bufnr) abort
    let l:precmd = a:is_vertical ? 'botright vsplit ' : 'belowright split '
    let l:postcmd = '| buffer '. a:bufnr
    execute l:precmd . l:postcmd
endfunction

function s:Open(is_vertical, cmd, bufnr) abort
    if a:bufnr
        call s:Reuse(a:is_vertical, a:bufnr)
    else
        call s:Create(a:is_vertical, a:cmd)
    endif
endfunction

function s:IsInactiveTerminal(bufnr) abort
    if !bufexists(a:bufnr) || !s:IsTerminal(a:bufnr) || bufwinid(a:bufnr) != -1
        return v:false
    endif
    return v:true
endfunction

function s:InactiveList(cmd) abort
    let l:bufnrs = filter(range(1, bufnr('$')), {index, value -> s:IsInactiveTerminal(value)})
    for l:bufnr in l:bufnrs
        let l:cmd = terminal#PS(l:bufnr).cmd
        if l:cmd ==? a:cmd
            return l:bufnr
        endif
    endfor
    return 0
endfunction

function terminal#SmartOpen(cmd) abort
    let [l:wintype, l:winlist] = winlayout()
    let l:bufnr = s:InactiveList(a:cmd)

    if l:wintype ==# 'row'
        call reverse(l:winlist)

        for [l:wintype, l:winid] in l:winlist
            if l:wintype !=# 'leaf'
                continue
            endif
            let l:is_terminal = getwininfo(l:winid)[0].terminal
            if l:is_terminal
                noautocmd call win_gotoid(l:winid)
                call s:Open(v:false, a:cmd, l:bufnr)
                return
            endif
        endfor
    endif

    call s:Open(v:true, a:cmd, l:bufnr)
endfunction

function terminal#PS(bufnr) abort
    if has('nvim')
        let l:pid = getbufvar(a:bufnr, 'terminal_job_pid')
        let l:tty = system('ps -o tty= '. l:pid)[:-2]
    else
        let l:tty = term_gettty(a:bufnr)
    endif

    let l:ps = system('ps -o stat= -o pid= -o command= -t '. l:tty)
    for l:item in reverse(split(l:ps, '\n'))
        let l:split_item = split(l:item)
        let l:stat = l:split_item[0]
        if l:stat !~# '+'
            continue
        endif

        let l:foreground_ps = {
                    \   'pid': l:split_item[1],
                    \   'cmd': l:split_item[2:],
                    \}
        if l:foreground_ps.cmd[0] ==# 'fzf'
            break
        endif
    endfor

    if !exists('l:foreground_ps')
        throw 'Fail to get terminal foreground process!'
    endif

    let l:cmd = fnamemodify(l:foreground_ps.cmd[0], ':t')
    if l:cmd =~? '\v^python' && exists('l:foreground_ps.cmd[1]')
        let l:cmd = fnamemodify(l:foreground_ps.cmd[1], ':t')
    endif

    return {'pid': l:foreground_ps.pid, 'cmd': l:cmd}
endfunction

function terminal#GetCwd(pid) abort
    if has('macunix')
        if executable('lsof')
            let l:lsof = system('lsof -aFn -d cwd -p '. a:pid)
            return split(l:lsof, '\n')[-1][1:]
        endif
    else
        if executable('pwdx')
            let l:pwdx = system('pwdx '. a:pid)
            return l:pwdx[stridx(l:pwdx, '/') : -2]
        elseif isdirectory('/proc/')
            return system('readlink /proc/'. a:pid .'/cwd')[:-2]
        endif
    endif

    throw 'Fail to get terminal working direcroty!'
endfunction
