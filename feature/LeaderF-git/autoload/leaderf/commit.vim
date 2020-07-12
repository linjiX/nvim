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

let leaderf#commit#hightlight_def = {
            \   'Lf_hl_match4': '^\x*',
            \   'Lf_hl_match1': '\v\(((HEAD -\> \w*|origin\/\w*|ref\/\w*)(, )?)+\)',
            \}

function leaderf#commit#Command(args) abort
    return 'git log --oneline --decorate'
endfunction

function leaderf#commit#BCommand(args) abort
    return 'git log --oneline --decorate '. expand('%:p')
endfunction

function leaderf#commit#Accept(line, args) abort
    let l:commit = split(a:line, ' ')[0]
    execute 'Gedit '. l:commit
endfunction

function leaderf#commit#Preview(orig_bufnr, orig_cursor, line, args) abort
    let l:commit = split(a:line, ' ')[0]
    let l:object = fugitive#Open('', 0, '', '', [l:commit])
    let bufnr = bufadd(l:object[1:])
    return [bufnr, 0, '']
endfunction
