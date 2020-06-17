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

let commit#hightlight_def = {
            \   'Lf_hl_match4': '^\x*',
            \   'Lf_hl_match1': '\v\(((HEAD -\> \w*|origin\/\w*|ref\/\w*)(, )?)+\)',
            \}

function commit#Command(args) abort
    return 'git log --oneline --decorate'
endfunction

function commit#BCommand(args) abort
    return 'git log --oneline --decorate '. expand('%:p')
endfunction

function commit#Accept(line, args) abort
    let l:commit = split(a:line, ' ')[0]
    execute 'Gedit '. l:commit
endfunction
