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

if has('nvim')
    function terminal#GetJobID(bufnr) abort
        return getbufvar(str2nr(a:bufnr), 'terminal_job_id')
    endfunction

    function terminal#AutoCmdInsert() abort
        if !exists('g:insert_skip') && exists('b:terminal_navigate')
            unlet b:terminal_navigate
            startinsert
        endif
    endfunction

    let s:ESC = "\<C-\>\<C-n>" . ":let b:terminal_navigate = 1\<CR>"
    let s:INSERT = ":call terminal#AutoCmdInsert()\<CR>"
    let s:INSERT_PRE = ":let g:insert_skip = 1\<CR>"
    let s:INSERT_POST = ":unlet g:insert_skip\<CR>" . s:INSERT
else
    let s:ESC = "\<C-v>"
    let s:INSERT = ''
    let s:INSERT_PRE = ''
    let s:INSERT_POST = ''
endif

function s:CmdModify(cmd) abort
    return fnamemodify(a:cmd, ':t')
endfunction

let s:SHELL = s:CmdModify($SHELL)

function terminal#Detach() abort
    return s:ESC .":quit\<CR>"
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
        setlocal nocursorcolumn
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

function s:Open(is_vertical, union) abort
    if type(a:union) == v:t_number
        call s:Reuse(a:is_vertical, a:union)
    else
        call s:Create(a:is_vertical, a:union)
    endif
endfunction

function s:SmartOpen(union) abort
    let [l:wintype, l:winlist] = winlayout()
    if l:wintype ==# 'row'
        call reverse(l:winlist)

        for [l:wintype, l:winid] in l:winlist
            if l:wintype !=# 'leaf'
                continue
            endif
            if !buflisted(getwininfo(l:winid)[0].bufnr)
                noautocmd call win_gotoid(l:winid)
                call s:Open(v:false, a:union)
                return
            endif
        endfor
    endif

    call s:Open(v:true, a:union)
endfunction

function s:IsInactiveTerminal(bufnr) abort
    if !bufexists(a:bufnr) || !s:IsTerminal(a:bufnr) || bufwinid(a:bufnr) != -1
        return v:false
    endif
    return v:true
endfunction

function s:InactiveList() abort
    return filter(range(1, bufnr('$')), {index, value -> s:IsInactiveTerminal(value)})
endfunction

function terminal#SmartOpen(cmd) abort
    let l:bufnrs = s:InactiveList()
    let l:union = strlen(a:cmd) ? a:cmd : s:SHELL
    for l:bufnr in l:bufnrs
        let l:cmd = terminal#PS(l:bufnr).cmd
        if l:cmd ==? l:union
            let l:union = l:bufnr
            break
        endif
    endfor
    call s:SmartOpen(l:union)
endfunction

function terminal#Attach() abort
    let l:bufnrs = s:InactiveList()
    if empty(l:bufnrs)
        echo 'No detached terminal!'
        return
    endif

    if len(l:bufnrs) == 1
        call s:SmartOpen(l:bufnrs[0])
        return
    endif

    let l:input_message = "Detached terminals: \n"
    for l:bufnr in l:bufnrs
        let l:input_message .= printf("%6s: %s \n", l:bufnr, terminal#PS(l:bufnr).cmd)
    endfor
    let l:input_message .= 'Select targat terminal: '

    call inputsave()
    let l:bufnr = input(l:input_message)
    call inputrestore()
    if !l:bufnr
        return
    endif

    call s:SmartOpen(str2nr(l:bufnr))
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

    let l:cmd = s:CmdModify(l:foreground_ps.cmd[0])
    if l:cmd =~? '\v^python' && exists('l:foreground_ps.cmd[1]')
        let l:cmd = s:CmdModify(l:foreground_ps.cmd[1])
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

let s:switch_mode = {
            \   'first': [{-> range(1, bufnr('$'))}, 'No termianl', '-t^'],
            \   'last': [{-> range(bufnr('$'), 1, -1)}, 'No terminal', '-t\{end\}'],
            \   'next': [{-> range(bufnr() + 1, bufnr('$'))}, 'No next terminal', '-n'],
            \   'previous': [{-> range(bufnr() - 1, 1, -1)}, 'No previous terminal', '-p'],
            \ }

call plug#load('vim-tmux-navigator')

function s:GetTmuxCommand() abort
    if exists('s:TmuxCommand')
        return s:TmuxCommand
    endif
    let l:file = 'vim-tmux-navigator/plugin/tmux_navigator.vim'
    let l:snr = utility#ScriptSNR(l:file)
    let s:TmuxCommand = function(printf('<SNR>%d_TmuxCommand', l:snr))
    return s:TmuxCommand
endfunction

function terminal#Select(mode) abort
    let [l:Range, l:msg, l:flag] = s:switch_mode[a:mode]
    if !s:IsTerminal(bufnr())
        let l:TmuxCommand = s:GetTmuxCommand()
        call l:TmuxCommand('select-window ' . l:flag)
        return
    endif

    let l:range = l:Range()
    for l:bufnr in l:range
        if !s:IsTerminal(l:bufnr)
            continue
        endif
        return s:ESC . ':buffer ' . l:bufnr . "\<CR>"
    endfor

    return s:ESC . ":echo '" . l:msg . "'\<CR>" . s:INSERT
endfunction
