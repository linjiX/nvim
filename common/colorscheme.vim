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

let g:solarized_termtrans = 1

function s:AutoCmdColorScheme() abort
    highlight Sneak cterm=bold,underline ctermfg=red
    highlight MatchParen NONE term=bold,underline cterm=bold,underline gui=bold,underline
    highlight link ctrlsfMatch StatusLineNC

    highlight UserError cterm=bold,underline ctermfg=9
    highlight UserWarning cterm=bold,underline ctermfg=13
    highlight UserInfo cterm=bold,underline ctermfg=12
    highlight UserErrorSign cterm=bold ctermfg=9 ctermbg=0
    highlight UserWarningSign cterm=bold ctermfg=13 ctermbg=0
    highlight UserInfoSign cterm=bold ctermfg=12 ctermbg=0

    highlight link CocErrorSign UserErrorSign
    highlight link CocWarningSign UserWarningSign
    highlight link CocInfoSign UserInfoSign
    highlight link CocHintSign UserInfoSign
    highlight link CocErrorHighlight UserError
    highlight link CocWarningHighlight UserWarning
    highlight link CocInfoHighlight UserInfo
    highlight link CocHintHighlight UserInfo

    highlight link CocHighlightText CursorLine
    highlight link HighlightedyankRegion StatusLine

    highlight link ALEErrorSign UserErrorSign
    highlight link ALEWarningSign UserWarningSign
    highlight link ALEInfoSign UserInfoSign

    highlight ALEError NONE
    highlight ALEWarning NONE
    highlight ALEInfo NONE

    highlight link ExtraWhitespace Visual
endfunction

function s:AutoCmdSolarzed() abort
    highlight CursorLineNr term=bold cterm=bold ctermfg=11 gui=bold guifg=Yellow
    highlight UserFloating ctermbg=232
    highlight link CocFloating UserFloating
    highlight link EchoDocFloat UserFloating
    highlight link NormalFloat UserFloating
endfunction

function s:AutoCmdMolokai() abort
    highlight Visual ctermbg=238
    highlight! link CursorLine CursorColumn
    highlight link CocFloating Visual
    highlight link EchoDocFloat Visual
    highlight link NormalFloat Visual
endfunction

augroup myColorScheme
    autocmd!
    autocmd ColorScheme * call <SID>AutoCmdColorScheme()
    autocmd ColorScheme solarized call <SID>AutoCmdSolarzed()
    autocmd ColorScheme molokai call <SID>AutoCmdMolokai()
augroup END
