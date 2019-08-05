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

" Plug 'glts/vim-textobj-comment'
let g:textobj_comment_no_default_key_mappings = 1

xmap am <Plug>(textobj-comment-a)
omap am <Plug>(textobj-comment-a)
xmap im <Plug>(textobj-comment-i)
omap im <Plug>(textobj-comment-a)
xmap aM <Plug>(textobj-comment-big-a)
omap aM <Plug>(textobj-comment-big-a)

" Plug 'sgur/vim-textobj-parameter'
let g:vim_textobj_parameter_mapping = 'a'

" Plug 'kana/vim-textobj-function'
" COC mapping the 'af' and 'if' for LS function textobj, but it doesn't work now
function s:AutoCmdTextobj() abort
    xmap af <Plug>(textobj-function-a)
    omap af <Plug>(textobj-function-a)
    xmap if <Plug>(textobj-function-i)
    omap if <Plug>(textobj-function-i)
endfunction

augroup myTextobj
    autocmd!
    autocmd BufRead * call <SID>AutoCmdTextobj()
augroup END
