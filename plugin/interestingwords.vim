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

let g:interestingWordsTermColors = ['002', '004', '005', '006', '013', '009']

function IsSearch() abort
    let l:origin_pos = getpos('.')
    call search(@/, 'c')
    if l:origin_pos == getpos('.')
        let l:is_search = 1
    else
        let l:is_search = 0
    endif
    call setpos('.', l:origin_pos)
    return l:is_search
endfunction

function s:UserPrintMatches() abort
    if IsSearch() == 1
        SearchIndex
    endif
endfunction
command -bar UserSearchIndex call <SID>UserPrintMatches()

nnoremap <silent> <leader>k :call InterestingWords('n')<CR>
vmap <leader>k <Plug>InterestingWords

nnoremap <silent> <BS> :call UncolorAllWords()<CR>:nohlsearch<CR>

nnoremap <silent> n :silent call WordNavigation(1)<CR>:UserSearchIndex<CR>
            \:if IsSearch() == 1<CR>let v:hlsearch = 1<CR>endif<CR>
nnoremap <silent> N :silent call WordNavigation(0)<CR>:UserSearchIndex<CR>
            \:if IsSearch() == 1<CR>let v:hlsearch = 1<CR>endif<CR>
