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

function terminal#Navigate(direction) abort
    if terminal#PS(bufnr()).cmd ==# 'fzf'
        if a:direction ==# 'j'
            return "\<C-j>"
        elseif a:direction ==# 'k'
            return "\<C-k>"
        endif
    endif
    if has('nvim')
        let l:esc = "\<C-\>\<C-n>"
        let l:flag = ":let b:terminal_navigate = 1\<CR>"
        let l:cmd = NavigateCmd(a:direction)
        return l:esc . l:flag . l:cmd
    else
        return "\<C-v>". NavigateCmd(a:direction)
    endif
endfunction

if has('nvim')
    function terminal#AutoCmdNavigate() abort
        if exists('b:terminal_navigate')
            unlet b:terminal_navigate
            startinsert
        endif
    endfunction
else
    function terminal#AutoCmdWipeTerminal() abort
        if &buftype ==# 'terminal'
            set bufhidden=wipe
        endif
    endfunction
endif

function terminal#AutoCmdTerminal() abort
    setlocal nonumber
    setlocal nobuflisted

    nnoremap <silent><buffer> <leader>q :q!<CR>
    nnoremap <silent><buffer> q :q!<CR>
    cnoreabbrev <buffer> q q!

    if has('nvim')
        setlocal bufhidden=wipe
        startinsert
    endif
endfunction

function s:Open(is_vertical, cmd) abort
    if has('nvim')
        let l:precmd = a:is_vertical ? 'botright vsplit ' : 'belowright split '
        let l:postcmd = 'term://'. a:cmd
    else
        let l:precmd = a:is_vertical ? 'vertical botright ' : 'belowright '
        let l:postcmd = 'terminal ++close '. a:cmd
    endif

    execute l:precmd . l:postcmd
endfunction

function terminal#SmartOpen(cmd) abort
    let [l:wintype, l:winlist] = winlayout()

    if l:wintype ==# 'row'
        call reverse(l:winlist)

        for [l:wintype, l:winid] in l:winlist
            if l:wintype !=# 'leaf'
                continue
            endif
            let l:is_terminal = getwininfo(l:winid)[0].terminal
            if l:is_terminal
                noautocmd call win_gotoid(l:winid)
                call s:Open(v:false, a:cmd)
                return
            endif
        endfor
    endif

    call s:Open(v:true, a:cmd)
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

function terminal#GetCwd(bufnr) abort
    let l:pid = terminal#PS(a:bufnr).pid

    if has('macunix')
        if executable('lsof')
            let l:lsof = system('lsof -aFn -d cwd -p '. l:pid)
            return split(l:lsof, '\n')[-1][1:]
        endif
    else
        if executable('pwdx')
            let l:pwdx = system('pwdx '. l:pid)
            return l:pwdx[stridx(l:pwdx, '/') : -2]
        elseif isdirectory('/proc/')
            return system('readlink /proc/'. l:pid .'/cwd')[:-2]
        endif
    endif

    throw 'Fail to get terminal working direcroty!'
endfunction
