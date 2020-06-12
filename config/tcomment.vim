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
let g:tcomment_maps = 0
let g:tcomment#blank_lines = 0

function s:TCommentYank(line1, line2, paste) abort
    silent execute a:line1 .','. a:line2 .'yank'
    silent execute a:line1 .','. a:line2 .'TComment'
    if a:paste
        silent execute a:line2 .'put'
    endif
endfunction

command! -range TCommentYank :call s:TCommentYank(<line1>, <line2>, 0)
command! -range TCommentPaste :call s:TCommentYank(<line1>, <line2>, 1)

nmap <silent> gc <Plug>TComment_gc
xmap <silent> gc <Plug>TComment_gc
nmap <silent> gcc <Plug>TComment_gcc
nmap <silent> gcs <Plug>TComment_gcb

nmap <silent> <leader>cc <Plug>TComment_<Leader>__
xmap <silent> <leader>cc <Plug>TComment_<Leader>__
nmap <silent> <leader>cs <Plug>TComment_<Leader>_b
xmap <silent> <leader>cs <Plug>TComment_<Leader>_b
nmap <silent> <leader>cr <Plug>TComment_<Leader>_r
xmap <silent> <leader>cr <Plug>TComment_<Leader>_r
nmap <silent> <leader>ca <Plug>TComment_<Leader>_a
xmap <silent> <leader>ca <Plug>TComment_<Leader>_a
xmap <silent> <leader>ci <Plug>TComment_<Leader>_i

nnoremap <silent> <leader>cy :TCommentYank<CR>
xnoremap <silent> <leader>cy :TCommentYank<CR>
nnoremap <silent> <leader>cp :TCommentPaste<CR>
xnoremap <silent> <leader>cp :TCommentPaste<CR>
