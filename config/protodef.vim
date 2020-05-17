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

let g:protodefprotogetter = $VIM_HOME .'/plug/vim-protodef/pullproto.pl'
let g:disable_protodef_mapping = 1

function s:ProtoDef(includeNS) abort
    let l:text = protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS' : a:includeNS})
    call append(line('.'), split(l:text, '\n'))
endfunction
command! ProtoDef call <SID>ProtoDef(1)
