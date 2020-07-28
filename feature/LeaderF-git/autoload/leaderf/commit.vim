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
    let l:cmd = 'git log --oneline --decorate'
    return leaderf#utility#Command(l:cmd)
endfunction

function leaderf#commit#BCommand(args) abort
    let l:cmd = 'git log --oneline --decorate '. expand('%:p')
    return leaderf#utility#Command(l:cmd)
endfunction

function s:Accept(line) abort
    if !s:CheckFugitive()
        return
    endif

    let l:commit = split(a:line, ' ')[0]
    execute 'Gedit '. l:commit
endfunction

function leaderf#commit#Accept(line, args) abort
    call leaderf#utility#Wrap(function('s:Accept'), a:line)
endfunction

function s:Preview(line)
    let l:commit = split(a:line, ' ')[0]
    return leaderf#commit#CommitPreview(l:commit)
endfunction

function leaderf#commit#Preview(orig_bufnr, orig_cursor, line, args) abort
    return leaderf#utility#Wrap(function('s:Preview'), a:line)
endfunction

function leaderf#commit#CommitPreview(commit) abort
    if !s:CheckFugitive()
        return
    endif
    let l:object = fugitive#Open('', 0, '', '', [a:commit])[1:]
    let l:bufnr = bufadd(l:object)
    return [l:bufnr, 0, '']
endfunction

function s:CheckFugitive() abort
    if exists(':Gedit') == 2
        return v:true
    endif

    echohl WarningMsg
    echo 'vim-fugitive not found'
    echohl None
    return v:false
endfunction
