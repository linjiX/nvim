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

let g:protodefprotogetter = '~/.vim/plug/vim-protodef/pullproto.pl'
let g:disable_protodef_mapping = 1
" let g:disable_protodef_sorting = 1

function s:ProtoDef(includeNS) abort
    if a:includeNS == 1
        let l:protos = protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})
    else
        let l:protos = protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS' : 0})
    endif
    call append(line('.'), split(l:protos, '\n'))
endfunction
command! ProtoDef call <SID>ProtoDef(1)

