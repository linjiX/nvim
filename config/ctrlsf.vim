""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/nvim                                "
"     _  _          _  _ __  __    __             _                "
"    | |(_) _ __   (_)(_)\ \/ /   / /_ __ __   __(_) _ __ ___      "
"    | || || '_ \  | || | \  /   / /| '_ \\ \ / /| || '_ ` _ \     "
"    | || || | | | | || | /  \  / / | | | |\ V / | || | | | | |    "
"    |_||_||_| |_|_/ ||_|/_/\_\/_/  |_| |_| \_/  |_||_| |_| |_|    "
"                |__/                                              "
"                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('rg')
    let g:ctrlsf_ackprg = 'rg'
endif

let g:ctrlsf_position = 'right'
let g:ctrlsf_default_root = 'project+fw'
let g:ctrlsf_winsize = '45%'
let g:ctrlsf_ignore_dir = ['bazel-*', 'build', 'devel', 'install']
let g:ctrlsf_auto_focus = {
            \   'at' : 'done',
            \   'duration_less_than': 1000
            \}

function s:AutoCmdCtrlSF() abort
    setlocal colorcolumn=107
    nnoremap <silent><buffer> <leader>q :CtrlSFClose<CR>
endfunction

augroup myCtrlSF
    autocmd!
    autocmd FileType ctrlsf call s:AutoCmdCtrlSF()
augroup END

nmap <leader>s<Space> <Plug>CtrlSFPrompt
nmap <leader>sC <Plug>CtrlSFCwordPath
nmap <leader>sc <Plug>CtrlSFCwordExec
nmap <leader>sS <Plug>CtrlSFCCwordPath
nmap <leader>ss <Plug>CtrlSFCCwordExec
nmap <leader>sP <Plug>CtrlSFPwordPath
nmap <leader>sp <Plug>CtrlSFPwordExec
xmap <leader>sS <Plug>CtrlSFVwordPath
xmap <leader>ss <Plug>CtrlSFVwordExec
nnoremap <leader>so :CtrlSFToggle<CR>
