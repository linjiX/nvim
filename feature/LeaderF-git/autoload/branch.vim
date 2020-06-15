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

function branch#Accept(line, args) abort
    call system('git switch ' . a:line)
    echo 'Switched to branch: '. a:line
endfunction

function branch#FormatList(list, args) abort
    return filter(copy(a:list), 'v:val[0] !=# "*"')
endfunction

function branch#FormatLine(line, args) abort
    return trim(a:line)
endfunction
