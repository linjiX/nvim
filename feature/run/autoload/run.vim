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

let s:binary_mapping = {
            \   'python': 'python3',
            \   'sh' : 'bash',
            \}

let s:cmdline_mapping = {
            \   'markdown': 'MarkdownPreview',
            \   'vim': 'source %',
            \}
if has('macunix')
    let s:cmdline_mapping['html'] = "call system('open '. expand('%'))"
endif

function s:GetShellCommand(expand) abort
    let l:executor = s:binary_mapping[&filetype]
    if !a:expand
        return l:executor . ' %'
    endif

    let l:root = FindRootDirectory()
    if empty(l:root)
        let l:root = getcwd()
    endif
    execute 'lcd '. l:root
    let l:cmd = l:executor . ' ' . fnameescape(expand('%:.'))
    lcd -
    return [l:root, l:cmd]
endfunction

function s:GetCmdline() abort
    try
        return s:cmdline_mapping[&l:filetype]
    catch /^Vim\%((\a\+)\)\=:E716/
        return ''
    endtry
endfunction

function run#Run() abort
    let l:cmdline = s:GetCmdline()
    if !empty(l:cmdline)
        execute l:cmdline
        echo l:cmdline
        return
    endif
    try
        let [l:root, l:cmd] = s:GetShellCommand(v:true)
        call SlimeRun(l:root, l:cmd)
    catch /^Vim\%((\a\+)\)\=:E716/
        echo 'Filetype not supported!'
    endtry
endfunction

function run#AsyncRun() abort
    try
        let l:cmd = s:GetShellCommand(v:false)
        execute 'AsyncRun -cwd=<root> '. l:cmd
    catch /^Vim\%((\a\+)\)\=:E716/
        echo 'Filetype not supported!'
    endtry
endfunction

function run#AsyncRunBlock() abort
    try
        let l:executor = s:binary_mapping[&filetype]
        return ':AsyncRun -raw '. l:executor ."\<CR>"
    catch /^Vim\%((\a\+)\)\=:E716/
        echo 'Filetype not supported!'
    endtry
endfunction

