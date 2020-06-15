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

let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})

let g:Lf_Extensions.branch = {
            \   'source': {'command': 'git branch'},
            \   'accept': 'branch#Accept',
            \   'format_list': 'branch#FormatList',
            \   'format_line': 'branch#FormatLine',
            \}

let g:Lf_Extensions.gstatus = {
            \   'source': {'command': 'git status -s -u'},
            \   'accept': 'gstatus#Accept',
            \}

let g:Lf_Extensions.commit = {
            \   'source': {'command': function('commit#Command')},
            \   'accept': 'commit#Accept',
            \}

let g:Lf_Extensions.bcommit = {
            \   'source': {'command': function('commit#BCommand')},
            \   'accept': 'commit#Accept',
            \}

let g:Lf_Extensions.gfile = {
            \   'source': {'command': 'git ls-files'},
            \   'accept': 'gfile#Accept',
            \   'supports_name_only': 1,
            \}
