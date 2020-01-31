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
            \ 'default': 'bash'
            \ }

if has('nvim')
    function s:SlimeConfig(bufnrs) abort
        let l:jobids = map(a:bufnrs, 'getbufvar(v:val, "terminal_job_id")')
        if !exists('b:slime_config') ||
         \ !has_key(b:slime_config, 'jobid') ||
         \ index(l:jobids, b:slime_config['jobid']) == -1
            let b:slime_config = {'jobid': min(l:jobids)}
        endif
    endfunction
else
    function s:SlimeConfig(bufnrs) abort
        if !exists('b:slime_config') ||
         \ !has_key(b:slime_config, 'bufnr') ||
         \ index(a:bufnrs, b:slime_config['bufnr']) == -1
            let b:slime_config = {'bufnr': min(a:bufnrs)}
        endif
    endfunction
endif

function s:SlimeGetTerminalCommand(bufnr) abort
    if has('nvim')
        let l:pid = getbufvar(a:bufnr, 'terminal_job_pid')
        let l:tty = system('ps -o tty= '. l:pid)
    else
        let l:tty = term_gettty(a:bufnr)
    endif

    let l:ps = system('ps -o stat= -o command= -t '. l:tty)
    for l:item in split(l:ps, '\n')
        let l:list = split(l:item)
        if l:list[0] =~# '+'
            return split(l:list[-1], '/')[-1]
        endif
    endfor
    echoerr 'Fail to get terminal command!'
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

function s:SlimeOpenTerminal() abort
    let l:winid = win_getid()
    try
        let l:cmds = get(g:slime_command, &filetype, [])
        for l:cmd in l:cmds
            if executable(l:cmd)
                return s:SlimeOpenTerminalCmd(l:cmd)
            endif
        endfor
        return s:SlimeOpenTerminalCmd(g:slime_command.default)
    finally
        call win_gotoid(l:winid)
    endtry
endfunction

function s:SlimeAvailableTerminals() abort
    let l:bufnrs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufnrs = filter(l:bufnrs, 'getbufvar(v:val, "&buftype") ==# "terminal"')
    if !has('nvim')
        let l:bufnrs = filter(l:bufnrs, 'term_getstatus(v:val) =~# "running"')
    endif

    let l:cmds = get(g:slime_command, &filetype, [g:slime_command.default])
    for l:bufnr in l:bufnrs
        let l:cmd = s:SlimeGetTerminalCommand(l:bufnr)
        if index(l:cmds, l:cmd) == -1
            call remove(l:bufnrs, index(l:bufnrs, l:bufnr))
        endif
    endfor

    return l:bufnrs
endfunction

function s:SlimeSelectTerminal() abort
    let l:bufnrs = s:SlimeAvailableTerminals()
    if len(l:bufnrs) == 0
        let l:bufnrs = s:SlimeOpenTerminal()
    endif
    call s:SlimeConfig(l:bufnrs)
endfunction

nmap <silent> <leader>ec <Plug>SlimeConfig
nmap <silent> <leader>ea
            \ :call <SID>SlimeSelectTerminal()<CR>:call slime#send_range(1, line('$'))<CR>
vmap <silent> <leader>ee :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeRegionSend
nmap <silent> <leader>ee :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeLineSend
nmap <silent> <leader>ep :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeParagraphSend
nmap <silent> <leader>em :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeMotionSend
