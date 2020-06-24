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
            \   'get_digest': 'gstatus#GetDigest',
            \   'supports_name_only': 1,
            \   'highlights_def': {'Lf_hl_match1': '^.\S'},
            \}

let g:Lf_Extensions.commit = {
            \   'source': {'command': function('commit#Command')},
            \   'accept': 'commit#Accept',
            \   'highlights_def': commit#hightlight_def,
            \}

let g:Lf_Extensions.bcommit = {
            \   'source': {'command': function('commit#BCommand')},
            \   'accept': 'commit#Accept',
            \   'highlights_def': commit#hightlight_def,
            \}

let g:Lf_Extensions.gfile = {
            \   'source': {'command': 'git ls-files'},
            \   'accept': 'gfile#Accept',
            \   'get_digest': 'gfile#GetDigest',
            \   'supports_name_only': 1,
            \}

let g:Lf_SelfContent = get(g:, 'Lf_SelfContent', {})

command! -bar -nargs=0 LeaderfBranch Leaderf branch
let g:Lf_SelfContent['LeaderfBranch'] = 'search git branches'

command! -bar -nargs=0 LeaderfGstatus Leaderf gstatus
let g:Lf_SelfContent['LeaderfGstatus'] = 'search git status files'

command! -bar -nargs=0 LeaderfCommit Leaderf commit
let g:Lf_SelfContent['LeaderfCommit'] = 'search git commits'

command! -bar -nargs=0 LeaderfBCommit Leaderf bcommit
let g:Lf_SelfContent['LeaderfBCommit'] = 'search git commits for current buffer'

command! -bar -nargs=0 LeaderfGfile Leaderf gfile
let g:Lf_SelfContent['LeaderfGfile'] = 'search git ls-files'
