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

let g:gitgutter_preview_win_location = 'belowright'

nnoremap <silent> <leader>gl :GitGutter<CR>
nnoremap <silent> <leader>gf :GitGutterFold<CR>
nnoremap <silent> <leader>gq :GitGutterQuickFix<CR>:belowright copen<CR>
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)

omap ig <Plug>(GitGutterTextObjectInnerPending)
omap ag <Plug>(GitGutterTextObjectOuterPending)
xmap ig <Plug>(GitGutterTextObjectInnerVisual)
xmap ag <Plug>(GitGutterTextObjectOuterVisual)

nnoremap [rg :GitGutterEnable<CR>
nnoremap ]rg :GitGutterDisable<CR>
nnoremap yrg :GitGutterToggle<CR>

nnoremap [rG :GitGutterBufferEnable<CR>
nnoremap ]rG :GitGutterBufferDisable<CR>
nnoremap yrG :GitGutterBufferToggle<CR>
