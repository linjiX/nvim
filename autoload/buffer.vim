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

function s:GetListedBufWin() abort
    return filter(range(1, winnr('$')), 'getbufvar(winbufnr(v:val), "&buflisted") == 1')
endfunction

function buffer#Open(cmd) abort
    let l:wincmd = ''
    if (&buflisted == 0 && winnr('$') > 1)
        let l:win = s:GetListedBufWin()
        if len(l:win) >= 1
            let l:wincmd = ':'. l:win[0] ."wincmd w\<CR>"
        endif
    endif
    return l:wincmd . a:cmd
endfunction

function buffer#Quit() abort
    let l:listedbuf_num = len(s:GetListedBufWin())
    if l:listedbuf_num == 0 || (l:listedbuf_num == 1 && &buflisted == 1)
        return 'qa'
    endif
    return 'q'
endfunction
