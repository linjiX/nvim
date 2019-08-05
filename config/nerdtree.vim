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

let s:minwidth = 30
let s:ratio = 0.148

let g:NERDTreeWinSize = s:minwidth
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['bazel-', '\~$']
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
let g:tagbar_width = s:minwidth
let g:tagbar_indent = 0
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_left = 1

function s:WorkspaceToggle() abort
    let l:width = max([float2nr(&columns * s:ratio), s:minwidth])
    let g:NERDTreeWinSize = l:width
    let g:tagbar_width = l:width
    ToggleNERDTreeAndTagbar
endfunction

nnoremap <leader>F :NERDTreeFind<CR>
nnoremap <leader>w :call <SID>WorkspaceToggle()<CR>
