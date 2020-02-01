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
    let g:slime_target = 'neovim'
else
    let g:slime_target = 'vimterminal'
endif

let g:slime_no_mappings = 1
let g:slime_python_ipython = 1
" let g:slime_paste_file = s:vim_cache .'/slime_paste'

let g:slime_sleep_time_ms = 200
let g:slime_command = {
            \ 'python': ['ipython3', 'python3', 'ipython', 'python', 'bpython', 'ptpython'],
            \ 'default': ['bash'],
            \ }

function s:SlimeConfig(bufnrs, is_run) abort
    if !exists('b:slime_config')
        let b:slime_config = {}
    endif

    let l:key = a:is_run ? 'run' : 'slime'

    if !has_key(b:slime_config, l:key) || index(a:bufnrs, b:slime_config[l:key]) == -1
        let b:slime_config[l:key] = min(a:bufnrs)
    endif

    let l:slime_key = has('nvim') ? 'jobid' : 'bufnr'
    if has('nvim')
        let b:slime_config.jobid = getbufvar(b:slime_config[l:key], 'terminal_job_id')
    else
        let b:slime_config.bufnr = b:slime_config[l:key]
    endif
endfunction

if has('macunix')
    function s:SlimeGetTermianlCwd(pid) abort
        if executable('lsof')
            let l:lsof = system('lsof -aFn -d cwd -p '. a:pid)
            return split(l:lsof, '\n')[-1][1:]
        endif
        echoerr 'Fail to get terminal working direcroty, "lsof" is not executable!'
        return ''
    endfunction
else
    function s:SlimeGetTermianlCwd(pid) abort
        if executable('pwdx')
            let l:pwdx = system('pwdx '. a:pid)
            return l:pwdx[stridx(l:pwdx, '/'):]
        elseif isdirectory('/proc/')
            return system('readlink /proc/'. a:pid .'/cwd')
        endif
        echoerr 'Fail to get terminal working direcroty!'
        return ''
    endfunction
endif

function s:SlimeGetTerminalCommand(pid) abort
    let l:command = system('ps -o command= '. a:pid)
    let l:idx = strridx(l:command, '/') + 1
    return l:command[l:idx:-2]
endfunction

function s:SlimeGetTerminalPID(bufnr) abort
    if has('nvim')
        let l:pid = getbufvar(a:bufnr, 'terminal_job_pid')
        let l:tty = system('ps -o tty= '. l:pid)
    else
        let l:tty = term_gettty(a:bufnr)
    endif

    let l:ps = system('ps -o stat= -o pid= -t '. l:tty)
    for l:item in split(l:ps, '\n')
        let [l:stat, l:pid] = split(l:item)
        if l:stat =~# '+'
            return l:pid
        endif
    endfor
    echoerr 'Fail to get terminal command!'
    return 0
endfunction

function s:SlimeGetRunCommand(terminal_cwd, root_cwd) abort
    execute 'lcd '. a:root_cwd
    let l:filepath = escape(expand('%:.'), ' ')
    lcd -

    if &filetype ==# 'python'
        let l:run_cmd = 'python3 '. l:filepath
    elseif &filetype ==# 'sh'
        let l:run_cmd = 'bash '. l:filepath
    else
        echom 'Filetype not support!'
        return ''
    endif

    if a:terminal_cwd !=# a:root_cwd
        let l:cd_cmd = 'cd '. escape(a:root_cwd, ' ')
        return [l:cd_cmd, l:run_cmd]
    endif
    return [l:run_cmd]
endfunction

function s:SlimeRun() abort
    call s:SlimeSelectTerminal(v:true)

    let l:bufnr = b:slime_config.run
    let l:pid = s:SlimeGetTerminalPID(l:bufnr)

    let l:terminal_cwd = s:SlimeGetTermianlCwd(l:pid)
    let l:root_cwd = FindRootDirectory()
    if empty(l:root_cwd)
        let l:root_cwd = getcwd()
        echom l:root_cwd
    endif

    let l:cmds = s:SlimeGetRunCommand(l:terminal_cwd, l:root_cwd)
    for l:cmd in l:cmds
        execute 'SlimeSend1 '. l:cmd
    endfor
endfunction

function s:SlimeOpenTerminalCmd(cmd) abort
    let l:sleep = a:cmd ==# 'bash' ? g:slime_sleep_time_ms
                \                  : g:slime_sleep_time_ms * 2
    call terminal#SmartTerminal(a:cmd)
    if has('nvim')
        stopinsert
        set nonumber
        let b:terminal_navigate = 1
    endif
    execute 'sleep'. l:sleep .'m'
    return [bufnr('%')]
endfunction

function s:SlimeOpenTerminal(cmds) abort
    let l:winid = win_getid()
    try
        for l:cmd in a:cmds
            if executable(l:cmd)
                return s:SlimeOpenTerminalCmd(l:cmd)
            endif
        endfor
        echoerr 'Fail to open slime terminal!'
    finally
        call win_gotoid(l:winid)
    endtry
endfunction

function s:SlimeAvailableTerminals(cmds) abort
    let l:bufnrs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufnrs = filter(l:bufnrs, 'getbufvar(v:val, "&buftype") ==# "terminal"')
    if !has('nvim')
        let l:bufnrs = filter(l:bufnrs, 'term_getstatus(v:val) =~# "running"')
    endif

    for l:bufnr in l:bufnrs
        let l:pid = s:SlimeGetTerminalPID(l:bufnr)
        let l:cmd = s:SlimeGetTerminalCommand(l:pid)
        if index(a:cmds, l:cmd) == -1
            call remove(l:bufnrs, index(l:bufnrs, l:bufnr))
        endif
    endfor

    return l:bufnrs
endfunction

function s:SlimeSelectTerminal(is_run) abort
    let l:cmds = a:is_run ? g:slime_command.default
                \         : get(g:slime_command, &filetype, g:slime_command.default)
    let l:bufnrs = s:SlimeAvailableTerminals(l:cmds)
    if empty(l:bufnrs)
        let l:bufnrs = s:SlimeOpenTerminal(l:cmds)
    endif
    call s:SlimeConfig(l:bufnrs, a:is_run)
endfunction

nmap <silent> <leader>ec <Plug>SlimeConfig
nmap <silent> <leader>ea
            \ :call <SID>SlimeSelectTerminal(v:false)<CR>:call slime#send_range(1, line('$'))<CR>
vmap <silent> <leader>ee :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeRegionSend
nmap <silent> <leader>ee :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeLineSend
nmap <silent> <leader>ep :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeParagraphSend
nmap <silent> <leader>em :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeMotionSend
nmap <silent> <leader>r :call <SID>SlimeRun()<CR>
