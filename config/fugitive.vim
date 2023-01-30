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

function s:AutoCmdFugitive() abort
    setlocal nobuflisted
    nmap <silent><buffer> <leader>q gq
    nmap <silent><buffer> q gq
endfunction

function s:AutoCmdGit() abort
    setlocal nobuflisted
    nnoremap <silent><buffer> <leader>q :q<CR>
    nnoremap <silent><buffer> q :q<CR>
endfunction

function s:AutoCmdBlame() abort
    nnoremap <silent><buffer> <CR> :call <SID>VSplitBlame()<CR>
    nmap <silent><buffer> <leader>q gq
    nmap <silent><buffer> q gq
endfunction

function s:AutoCmdFlog() abort
    setlocal colorcolumn=0
    nnoremap <buffer> gb :call flog#run_command("GBrowse %(h)")<CR>
    nmap <silent><buffer> <leader>q gq
    nmap <silent><buffer> q gq
endfunction

function s:TabBlame(args) abort
    call Tabopen()
    execute 'Git blame '. a:args
    nnoremap <silent><buffer> <leader>q :tabclose<CR>
    nnoremap <silent><buffer> q :tabclose<CR>
    cnoreabbrev <silent><buffer> q tabclose
endfunction

let s:script = 'vim-fugitive/autoload/fugitive.vim'

function s:VSplitBlame() abort
    let l:BlameCommit = utility#ScriptFunction('BlameCommit', s:script)
    let l:old_config = utility#SetConfig({'&l:splitbelow': 1})
    try
        execute l:BlameCommit('vsplit')
    finally
        call utility#SetConfig(l:old_config)
    endtry
endfunction

augroup myGit
    autocmd!
    autocmd FileType fugitive call s:AutoCmdFugitive()
    autocmd FileType fugitiveblame call s:AutoCmdBlame()
    autocmd FileType git call s:AutoCmdGit()
    autocmd FileType gitcommit setlocal colorcolumn=72
    autocmd FileType floggraph call s:AutoCmdFlog()
augroup END

command! -bar -bang Gst vertical botright Git<bang>
command! -bar -bang -nargs=* -complete=customlist,fugitive#EditComplete Gd
            \ vertical botright Gdiffsplit<bang> <args>

command! -nargs=? -complete=customlist,fugitive#CommitComplete Gc
            \ vertical botright Git commit -v <args>
command! -nargs=? -complete=customlist,fugitive#CommitComplete Gca
            \ vertical botright Git commit -v -a <args>

command! -nargs=? -complete=customlist,fugitive#PushComplete Gpush
            \  let g:asyncrun_silent_mode = 1 | AsyncRun git push <args>

command! -nargs=? -complete=customlist,fugitive#BlameComplete Gblame call s:TabBlame(<q-args>)

command! -nargs=? -complete=customlist,fugitive#BlameComplete Grebase
            \ vertical botright Git rebase <args>

" Plug 'rhysd/git-messenger.vim'
let g:git_messenger_no_default_mappings = 1
nmap <leader>gm <Plug>(git-messenger)

" Plug 'tpope/vim-rhubarb'
nnoremap gb :.GBrowse<CR>
vnoremap gb :GBrowse<CR>

" Plug 'rbong/vim-flog'
let g:flog_permanent_default_opts = {
            \   'date': 'short',
            \}
