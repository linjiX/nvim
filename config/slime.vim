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
let g:slime_command = {'python': ['ipython3', 'python3', 'ipython', 'python']}

if has('nvim')
    function s:SlimeOpenTerminalCmd(...) abort
        let [l:cmd, l:sleep] = (a:0 == 0) ? ['bash', g:slime_sleep_time_ms]
                    \                     : [a:1, g:slime_sleep_time_ms * 2]
        execute 'botright vsplit term://'. l:cmd
        stopinsert
        execute 'sleep'. l:sleep .'m'
        return [bufnr('%')]
    endfunction

    function s:SlimeConfig(bufs) abort
        let l:jobids = map(a:bufs, 'getbufvar(v:val, "terminal_job_id")')
        echo l:jobids
        if !exists('b:slime_config') ||
         \ !has_key(b:slime_config, 'jobid') ||
         \ index(l:jobids, b:slime_config['jobid']) == -1
            let b:slime_config = {'jobid': min(l:jobids)}
        endif
    endfunction
else
    function s:SlimeOpenTerminalCmd(...) abort
        let [l:cmd, l:sleep] = (a:0 == 0) ? ['', g:slime_sleep_time_ms]
                    \                     : [' ++close '. a:1, g:slime_sleep_time_ms * 2]
        execute 'botright vertical terminal'. l:cmd
        execute 'sleep'. l:sleep .'m'
        return [bufnr('%')]
    endfunction

    function s:SlimeConfig(bufs) abort
        if !exists('b:slime_config') ||
         \ !has_key(b:slime_config, 'bufnr') ||
         \ index(a:bufs, b:slime_config['bufnr']) == -1
            let b:slime_config = {'bufnr': min(a:bufs)}
        endif
    endfunction
endif

function s:SlimeOpenTerminal() abort
    let l:winid = win_getid()
    try
        if has_key(g:slime_command, &filetype)
            for l:cmd in g:slime_command[&filetype]
                if executable(l:cmd)
                    return s:SlimeOpenTerminalCmd(l:cmd)
                endif
            endfor
        endif
        return s:SlimeOpenTerminalCmd()
    finally
        call win_gotoid(l:winid)
    endtry
endfunction

function s:SlimeAvailableTerminals() abort
    let l:bufs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufs = filter(l:bufs, 'getbufvar(v:val, "&buftype") ==# "terminal"')
    if !has('nvim')
        let l:bufs = filter(l:bufs, 'term_getstatus(v:val) =~# "running"')
    endif
    return l:bufs
endfunction

function s:SlimeSelectTerminal() abort
    let l:bufs = s:SlimeAvailableTerminals()
    if len(l:bufs) == 0
        let l:bufs = s:SlimeOpenTerminal()
    endif
    call s:SlimeConfig(l:bufs)
endfunction

function s:SlimeSelectTerminalFast() abort
    let l:temp = g:slime_sleep_time_ms
    let g:slime_sleep_time_ms = 1
    call s:SlimeSelectTerminal()
    let g:slime_sleep_time_ms = l:temp
endfunction

nmap <silent> <leader>ec <Plug>SlimeConfig
nmap <silent> <leader>eo :call <SID>SlimeSelectTerminalFast()<CR>
nmap <silent> <leader>ea ggVG:call <SID>SlimeSelectTerminal()<CR><Plug>SlimeRegionSend
vmap <silent> <leader>ee :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeRegionSend
nmap <silent> <leader>ee :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeParagraphSend
nmap <silent> <leader>el :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeLineSend
nmap <silent> <leader>em :call <SID>SlimeSelectTerminal()<CR><Plug>SlimeMotionSend
