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

function leaderf#branch#Command(args) abort
    let l:cmd = 'git branch'
    return leaderf#utility#Command(l:cmd)
endfunction

function leaderf#branch#Accept(line, args) abort
    let l:branch = a:line[2:]
    echo system('git switch ' . l:branch)
endfunction

function s:Preview(line)
    let l:commit = split(a:line, ' ')[0]
endfunction

function leaderf#branch#Preview(orig_bufnr, orig_cursor, line, args) abort
    return leaderf#utility#Wrap(function('s:Preview'), a:line)
endfunction
