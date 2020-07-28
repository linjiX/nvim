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
            \   'source': {'command': function('leaderf#branch#Command')},
            \   'accept': 'leaderf#branch#Accept',
            \   'preview': 'leaderf#branch#Preview',
            \   'highlights_def': {'Lf_hl_match4': '^\* .*'},
            \}

let g:Lf_Extensions.commit = {
            \   'source': {'command': function('leaderf#commit#Command')},
            \   'accept': 'leaderf#commit#Accept',
            \   'preview': 'leaderf#commit#Preview',
            \   'highlights_def': leaderf#commit#hightlight_def,
            \   'supports_multi': 1,
            \}

let g:Lf_Extensions.bcommit = {
            \   'source': {'command': function('leaderf#commit#BCommand')},
            \   'accept': 'leaderf#commit#Accept',
            \   'preview': 'leaderf#commit#Preview',
            \   'highlights_def': leaderf#commit#hightlight_def,
            \   'supports_multi': 1,
            \}

let g:Lf_Extensions.gfile = {
            \   'source': {'command': function('leaderf#gfile#Command')},
            \   'format_line': 'leaderf#gfile#FormatLine',
            \   'accept': 'leaderf#gfile#Accept',
            \   'preview': 'leaderf#gfile#Preview',
            \   'get_digest': 'leaderf#gfile#GetDigest',
            \   'after_enter': 'leaderf#gfile#AfterEnter',
            \   'supports_name_only': 1,
            \   'supports_multi': 1,
            \}

let g:Lf_Extensions.gstatus = {
            \   'source': {'command': function('leaderf#gstatus#Command')},
            \   'format_line': 'leaderf#gstatus#FormatLine',
            \   'accept': 'leaderf#gstatus#Accept',
            \   'preview': 'leaderf#gstatus#Preview',
            \   'get_digest': 'leaderf#gstatus#GetDigest',
            \   'after_enter': 'leaderf#gfile#AfterEnter',
            \   'highlights_def': {'Lf_hl_match1': '^.\S'},
            \   'supports_name_only': 1,
            \   'supports_multi': 1,
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
