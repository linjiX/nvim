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

set background=dark
set t_Co=256

function s:AutoCmdColorScheme() abort
    highlight Sneak cterm=bold,underline ctermfg=red
    highlight MatchParen NONE term=bold,underline cterm=bold,underline gui=bold,underline
    highlight link ctrlsfMatch StatusLineNC

    highlight UserError cterm=bold,underline ctermfg=9
    highlight UserWarning cterm=bold,underline ctermfg=13
    highlight UserInfo cterm=bold,underline ctermfg=12
    highlight UserErrorSign cterm=bold ctermfg=9
    highlight UserWarningSign cterm=bold ctermfg=13
    highlight UserInfoSign cterm=bold ctermfg=12

    highlight link YcmErrorSection UserError
    highlight link YcmErrorSign UserErrorSign
    highlight link YcmWarningSection UserWarning
    highlight link YcmWarningSign UserWarningSign

    highlight link ALEErrorSign UserErrorSign
    highlight link ALEWarningSign UserWarningSign
    highlight link ALEInfoSign UserInfoSign

    highlight link ALEError Normal
    highlight link ALEWarning Normal
    highlight link ALEInfo Normal

    highlight link ExtraWhitespace Visual
endfunction

function s:AutoCmdMolokai() abort
    highlight Visual ctermbg=238
    highlight! link CursorLine CursorColumn
endfunction

augroup myColorScheme
    autocmd!
    autocmd ColorScheme * call <SID>AutoCmdColorScheme()
    autocmd ColorScheme molokai call <SID>AutoCmdMolokai()
augroup END
