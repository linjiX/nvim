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

function s:GetListedBufWinnrs() abort
    let l:other_winnrs = range(1, winnr() - 1) + range(winnr() + 1, winnr('$'))
    return filter(l:other_winnrs, 'getbufvar(winbufnr(v:val), "&buflisted") == 1')
endfunction

function buffer#Open(cmd) abort
    let l:wincmd = ''
    if (&buflisted == 0 && winnr('$') > 1)
        let l:winnrs = s:GetListedBufWinnrs()
        if !empty(l:winnrs)
            let l:wincmd = ':'. l:winnrs[0] ."wincmd w\<CR>"
        endif
    endif
    return l:wincmd . a:cmd
endfunction

function buffer#Quit(is_write) abort
    let l:winnrs = s:GetListedBufWinnrs()
    if empty(l:winnrs)
        return tabpagenr('$') > 1 ? a:is_write ? 'w | tabclose' : 'tabclose'
                    \             : a:is_write ? 'w | qa' : 'qa'
    else
        return a:is_write ? 'wq' : 'q'
    endif
endfunction
