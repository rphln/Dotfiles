# Section: Environment

set --prepend PATH '.git/safe/../../bin'

set --export EDITOR 'code'
set --export VISUAL 'code --wait'

# Section: Abbreviations

abbr - 'cd -'

abbr 1 '../'
abbr 2 '../../'
abbr 3 '../../../'
abbr 4 '../../../../'

abbr c 'cp --no-clobber --recursive'
abbr m 'mv --no-clobber'

abbr r 'trash --'
abbr t 'touch --'

abbr v $EDITOR

abbr md 'mkdir --parents --'
abbr rd 'rmdir --parents --'

abbr sd 'sudo'
abbr se 'sudo --edit'

# Section: Git

abbr gd 'git diff'
abbr gm 'git merge'
abbr gs 'git status --short'
abbr gu 'git pull'

abbr ga 'git add'
abbr gap 'git add --patch'

abbr gb 'git rebase --interactive'
abbr gbn 'git rebase --interactive HEAD~9'
abbr gbr 'git rebase --interactive --root'

abbr gc 'git commit'
abbr gc! 'git commit --amend --reset-author'

abbr gcr 'git clone --recursive'

abbr gi 'git init'
abbr gig 'git ignore'

abbr gl 'git history'
abbr glo 'git history origin..HEAD'

abbr go 'git switch'
abbr gom 'git switch master'

abbr gp 'git push'
abbr gp! 'git push --force-with-lease'

abbr gr 'git restore'
abbr grs 'git restore --staged'

# Section: Keybindings

bind \cy 'yank-command'
bind \cs 'yank-path'

bind \co 'browse-here'

# Section: Overrides

set -U fish_features '3.0'
set -U fish_greeting

alias ls 'command ls --color --classify --group-directories-first'

function chpwd --on-variable PWD
    ls
end

set fish_prompt_pwd_dir_length 0

function prompt_pwd_tail --description "Prints the last two path components from `prompt_pwd`."
    string match --regex '(?:^/)?(?:[^/]+/?){0,2}$' (prompt_pwd)
end

function fish_prompt
    printf "%s: " (prompt_pwd_tail)
end

function fish_title
    printf "%s — %s" (prompt_pwd_tail) (status current-command)
end

for group in fish_color_autosuggestion fish_color_cancel fish_color_command fish_color_comment fish_color_cwd fish_color_cwd_root fish_color_end fish_color_error fish_color_escape fish_color_history_current fish_color_host fish_color_host_remote fish_color_match fish_color_normal fish_color_operator fish_color_param fish_color_quote fish_color_redirection fish_color_search_match fish_color_selection fish_color_status fish_color_user fish_color_valid_path fish_pager_color_background fish_pager_color_completion fish_pager_color_description fish_pager_color_prefix fish_pager_color_progress fish_pager_color_secondary_background fish_pager_color_secondary_completion fish_pager_color_secondary_description fish_pager_color_secondary_prefix fish_pager_color_selected_background fish_pager_color_selected_completion fish_pager_color_selected_description fish_pager_color_selected_prefix
    set $group normal
end

set fish_color_error brred

set fish_color_comment brblack
set fish_color_autosuggestion brblack
