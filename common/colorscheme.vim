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
    highlight Sneak cterm=bold,underline ctermfg=9 gui=bold,underline guifg=#cb4b16
    highlight MatchParen NONE cterm=bold,underline gui=bold,underline
    highlight MatchWord cterm=underline gui=underline
    highlight link ctrlsfMatch StatusLineNC

    highlight UserError cterm=bold,underline ctermfg=9 gui=bold,underline guifg=#cb4b16
    highlight UserWarning cterm=bold,underline ctermfg=13 gui=bold,underline guifg=#6c71c4
    highlight UserInfo cterm=bold,underline ctermfg=12 gui=bold,underline guifg=#839496

    highlight UserErrorSign cterm=bold ctermfg=9 ctermbg=0 gui=bold guifg=#cb4b16 guibg=#073642
    highlight UserWarningSign cterm=bold ctermfg=13 ctermbg=0 gui=bold guifg=#6c71c4 guibg=#073642
    highlight UserInfoSign cterm=bold ctermfg=12 ctermbg=0 gui=bold guifg=#839496 guibg=#073642

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
    highlight CursorLineNr cterm=bold ctermfg=11 gui=bold guifg=#657b83
    highlight UserFloating ctermbg=232 guibg=#080808
    highlight link CocFloating UserFloating
    highlight link EchoDocFloat UserFloating
    highlight link WhichKeyFloating UserFloating
    highlight link NormalFloat UserFloating
endfunction

function s:AutoCmdMolokai() abort
    highlight Visual ctermbg=238 guibg=#444444
    highlight! link CursorLine CursorColumn
    highlight link CocFloating Visual
    highlight link EchoDocFloat Visual
    highlight link WhichKeyFloating Visual
    highlight link NormalFloat Visual
endfunction

augroup myColorScheme
    autocmd!
    autocmd ColorScheme * call s:AutoCmdColorScheme()
    autocmd ColorScheme solarized call s:AutoCmdSolarzed()
    autocmd ColorScheme molokai call s:AutoCmdMolokai()
augroup END
