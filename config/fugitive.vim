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

function s:AutoCmdFugitive() abort
    setlocal nobuflisted
    nmap <silent><buffer> <leader>q gq
    nmap <silent><buffer> q gq
endfunction

augroup myGit
    autocmd!
    autocmd FileType fugitive,fugitiveblame call s:AutoCmdFugitive()
    autocmd FileType GV setlocal colorcolumn=0
augroup END

command! -bar -bang Gst vertical botright Gstatus<bang>
command! -bar -bang -nargs=* -complete=customlist,fugitive#EditComplete Gd
            \ vertical botright Gdiffsplit<bang> <args>

command! -nargs=? -complete=customlist,fugitive#CommitComplete Gc
            \ vertical botright Gcommit -v <args>
command! -nargs=? -complete=customlist,fugitive#CommitComplete Gca
            \ vertical botright Gcommit -v -a <args>

command! -nargs=? -complete=customlist,fugitive#PushComplete Gpush
            \ AsyncRun git push <args>

" Plug 'rhysd/git-messenger.vim'
let g:git_messenger_no_default_mappings = 1
nmap <Leader>gm <Plug>(git-messenger)
