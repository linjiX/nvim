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

function terminal#AutoCmdTerminal() abort
    " setlocal bufhidden=wipe
    setlocal nobuflisted
    nnoremap <silent><buffer> <leader>q :q!<CR>
    nnoremap <silent><buffer> q :q!<CR>
    cnoreabbrev <buffer> q q!
    if has('nvim')
        setlocal bufhidden=wipe
        startinsert
    endif
endfunction

function terminal#AutoCmdWipeTerminal() abort
    if &buftype ==# 'terminal'
        set bufhidden=wipe
    endif
endfunction

function terminal#AutoCmdNvimTerminal() abort
    if exists('b:terminal_navigate')
        unlet b:terminal_navigate
        startinsert
    endif
endfunction

function s:OpenTerminal(is_vertical, cmd) abort
    if has('nvim')
        let l:precmd = a:is_vertical ? 'botright vsplit ' : 'belowright split '
        let l:postcmd = 'term://'. a:cmd
    else
        let l:precmd = a:is_vertical ? 'vertical botright ' : 'belowright '
        let l:postcmd = 'terminal ++close '. a:cmd
    endif

    execute l:precmd . l:postcmd
endfunction

function terminal#SmartTerminal(cmd) abort
    let [l:wintype, l:winlist] = winlayout()

    if l:wintype ==# 'row'
        call reverse(l:winlist)

        for [l:wintype, l:winid] in l:winlist
            if l:wintype !=# 'leaf'
                continue
            endif
            let l:is_terminal = getwininfo(l:winid)[0].terminal
            if l:is_terminal
                call win_gotoid(l:winid)
                call s:OpenTerminal(v:false, a:cmd)
                return
            endif
        endfor
    endif

    call s:OpenTerminal(v:true, a:cmd)
    return
endfunction
