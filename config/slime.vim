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

let g:slime_target = has('nvim') ? 'neovim' : 'vimterminal'
let g:slime_no_mappings = 1
let g:slime_python_ipython = 1
let g:slime_paste_file = $MY_CACHE_PATH .'/slime_paste'

let s:slime_smart_mode = 1
let s:slime_sleep_time_ms = 200
let s:slime_run_filetype = ['python', 'sh']
let s:slime_repl = {
            \ 'python': ['ipython3', 'python3', 'ipython', 'python', 'bpython', 'ptpython'],
            \ 'default': ['bash'],
            \ }
function s:SlimeGetFiletypeCommand(is_run) abort
    return a:is_run ? s:slime_repl.default
                \   : get(s:slime_repl, &filetype, s:slime_repl.default)
endfunction

function s:SlimeGetConfigKey(is_run) abort
    return a:is_run ? 'run' : 'repl'
endfunction

function s:SlimeUserConfig(is_run) abort
    let l:cmds = s:SlimeGetFiletypeCommand(a:is_run)
    let l:bufnrs = s:SlimeAvailableTerminals(l:cmds)
    if empty(l:bufnrs)
        echo 'No available terminal!'
        return
    endif

    if !exists('b:slime_config')
        let b:slime_config = {}
    endif
    let l:key = s:SlimeGetConfigKey(a:is_run)
    let l:current_bufnr = get(b:slime_config, l:key, 0)

    let l:input_message = "Available terminals: \n"
    for l:bufnr in l:bufnrs
        let l:bufnr_message = (l:bufnr == l:current_bufnr) ? '['. l:bufnr .']'
                    \                                      : ' '. l:bufnr .' '
        let l:input_message .= printf("%6s: %s\n", l:bufnr_message, bufname(l:bufnr))
    endfor
    let l:input_message .= 'Select targat terminal: '

    call inputsave()
    let b:slime_config[l:key] = input(l:input_message, l:current_bufnr)
    call inputrestore()
endfunction

function s:SlimeConfig(bufnrs, is_run) abort
    if !exists('b:slime_config')
        let b:slime_config = {}
    endif

    let l:key = s:SlimeGetConfigKey(a:is_run)
    if !has_key(b:slime_config, l:key) || index(a:bufnrs, b:slime_config[l:key]) == -1
        let b:slime_config[l:key] = min(a:bufnrs)
    endif

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
        throw 'Fail to get terminal working direcroty, "lsof" is not executable!'
    endfunction
else
    function s:SlimeGetTermianlCwd(pid) abort
        if executable('pwdx')
            let l:pwdx = system('pwdx '. a:pid)
            return l:pwdx[stridx(l:pwdx, '/') : -2]
        elseif isdirectory('/proc/')
            return system('readlink /proc/'. a:pid .'/cwd')[:-2]
        endif
        throw 'Fail to get terminal working direcroty!'
    endfunction
endif

function s:SlimeGetTerminalCommand(pid) abort
    let l:command = system('ps -o command= '. a:pid)
    let l:idx = strridx(l:command, '/') + 1
    return l:command[l:idx : -2]
endfunction

function s:SlimeGetTerminalPID(bufnr) abort
    if has('nvim')
        let l:pid = getbufvar(a:bufnr, 'terminal_job_pid')
        let l:tty = system('ps -o tty= '. l:pid)[:-2]
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
    throw 'Fail to get foreground terminal PID!'
endfunction

function s:SlimeGetRunCommand(terminal_cwd, root_cwd) abort
    execute 'lcd '. a:root_cwd
    let l:filepath = fnameescape(expand('%:.'))
    lcd -

    if &filetype ==# 'python'
        let l:run_cmd = 'python3 '. l:filepath
    elseif &filetype ==# 'sh'
        let l:run_cmd = 'bash '. l:filepath
    else
        throw 'Filetype not support!'
    endif

    if a:terminal_cwd !=# a:root_cwd
        let l:cd_cmd = 'cd '. fnameescape(a:root_cwd)
        return l:cd_cmd ." && \\\n". l:run_cmd
    endif
    return l:run_cmd
endfunction

function s:Run() abort
    if &filetype ==# 'markdown'
        MarkdownPreview
    elseif index(s:slime_run_filetype, &filetype) != -1
        call s:SlimeRun()
    else
        echo 'Filetype not supported!'
    endif
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

    let l:cmd = s:SlimeGetRunCommand(l:terminal_cwd, l:root_cwd)

    if exists('g:slime_python_ipython')
        let l:ipython_config = g:slime_python_ipython
        unlet g:slime_python_ipython
    endif
    try
        execute 'SlimeSend1 '. l:cmd
    finally
        if exists('l:ipython_config')
            let g:slime_python_ipython = l:ipython_config
        endif
    endtry
endfunction

function s:SlimeOpenTerminalCmd(cmd) abort
    let l:sleep = a:cmd ==# 'bash' ? s:slime_sleep_time_ms
                \                  : s:slime_sleep_time_ms * 2
    call terminal#SmartTerminal(a:cmd)
    if has('nvim')
        stopinsert
        let b:terminal_navigate = 1
    endif
    execute 'sleep'. l:sleep .'m'
    return [bufnr()]
endfunction

function s:SlimeOpenTerminal(cmds) abort
    let l:winid = win_getid()
    try
        for l:cmd in a:cmds
            if executable(l:cmd)
                return s:SlimeOpenTerminalCmd(l:cmd)
            endif
        endfor
        throw 'Fail to open slime terminal!'
    finally
        noautocmd call win_gotoid(l:winid)
    endtry
endfunction

function s:SlimeAvailableTerminals(cmds) abort
    let l:bufnrs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufnrs = filter(l:bufnrs, 'getbufvar(v:val, "&buftype") ==# "terminal"')
    if !has('nvim')
        let l:bufnrs = filter(l:bufnrs, 'term_getstatus(v:val) =~# "running"')
    endif

    if s:slime_smart_mode
        for l:bufnr in l:bufnrs
            let l:pid = s:SlimeGetTerminalPID(l:bufnr)
            let l:cmd = s:SlimeGetTerminalCommand(l:pid)
            if index(a:cmds, l:cmd) == -1
                call remove(l:bufnrs, index(l:bufnrs, l:bufnr))
            endif
        endfor
    endif

    return l:bufnrs
endfunction

function s:SlimeSelectTerminal(is_run) abort
    let l:cmds = s:SlimeGetFiletypeCommand(a:is_run)
    let l:bufnrs = s:SlimeAvailableTerminals(l:cmds)
    if empty(l:bufnrs)
        let l:bufnrs = s:SlimeOpenTerminal(l:cmds)
    endif
    call s:SlimeConfig(l:bufnrs, a:is_run)
endfunction

function s:SlimeModeSwitch() abort
    let s:slime_smart_mode = !s:slime_smart_mode
    if s:slime_smart_mode
        echo 'Slime Smart Mode'
    else
        echo 'Slime Normal Mode'
    endif
endfunction

command! SlimeRunConfig call <SID>SlimeUserConfig(v:true)
command! SlimeReplConfig call <SID>SlimeUserConfig(v:false)
nmap <silent> <leader>ea
            \ :call <SID>SlimeSelectTerminal(v:false)<CR>:call slime#send_range(1, line('$'))<CR>
xmap <silent> <leader>ee :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeRegionSend
nmap <silent> <leader>ee :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeLineSend
nmap <silent> <leader>ep :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeParagraphSend
nmap <silent> <leader>em :call <SID>SlimeSelectTerminal(v:false)<CR><Plug>SlimeMotionSend
nmap <silent> <leader>es :call <SID>SlimeModeSwitch()<CR>
nmap <silent> <leader>r :call <SID>Run()<CR>
