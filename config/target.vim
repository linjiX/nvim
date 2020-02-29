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

let g:targets_nl = ['n', 'N']

let s:pairs = [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}]
let s:quotes = [{'d':"'"}, {'d':'"'}, {'d':'`'}]
let s:separators = [
            \   {'d':','}, {'d':'.'}, {'d':';'}, {'d':':'}, {'d':'+'}, {'d':'-'},
            \   {'d':'='}, {'d':'~'}, {'d':'_'}, {'d':'*'}, {'d':'#'}, {'d':'/'},
            \   {'d':'\'}, {'d':'|'}, {'d':'&'}, {'d':'$'},
            \]

augroup myTarget
    autocmd!
    autocmd User targets#mappings#user call targets#mappings#extend({
                \   'l': {'line': [{'c': 1}]},
                \   'b': {'pair': s:pairs},
                \   'v': {'pair': s:pairs, 'quote': s:quotes},
                \   'd': {'separator': s:separators},
                \   'o': {
                \       'pair': s:pairs,
                \       'quote': s:quotes,
                \       'separator': s:separators,
                \       'tag':[{}]
                \   },
                \})
augroup END

" Plug 'glts/vim-textobj-comment'
let g:textobj_comment_no_default_key_mappings = 1

xmap am <Plug>(textobj-comment-a)
omap am <Plug>(textobj-comment-a)
xmap im <Plug>(textobj-comment-i)
omap im <Plug>(textobj-comment-a)
xmap aM <Plug>(textobj-comment-big-a)
omap aM <Plug>(textobj-comment-big-a)
