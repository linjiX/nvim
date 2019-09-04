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

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDUsePlaceHolders = 0
let g:NERDCommenterMappings = 0
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = {'python': { 'left': '#', 'leftAlt': '', 'rightAlt': '' }}

map <leader>c<Space> <Plug>NERDCommenterComment
map <leader>cc <Plug>NERDCommenterToggle
map <leader>cm <Plug>NERDCommenterMinimal
map <leader>ci <Plug>NERDCommenterInvert
map <leader>cs <Plug>NERDCommenterSexy
map <leader>cy <Plug>NERDCommenterYank
map <leader>c$ <Plug>NERDCommenterToEOL
map <leader>cA <Plug>NERDCommenterAppend
map <leader>ca <Plug>NERDCommenterAltDelims
map <leader>cl <Plug>NERDCommenterAlignLeft
map <leader>cr <Plug>NERDCommenterAlignBoth
map <leader>cu <Plug>NERDCommenterUncomment
