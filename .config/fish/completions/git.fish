# Also load the default completions.
source {$__fish_data_dir}/completions/git.fish

set -g __fish_complete_git_ignore_cache /tmp/__fish_complete_git_ignore

function __fish_complete_git_ignore
    cat $__fish_complete_git_ignore_cache 2>/dev/null || begin
        curl --silent --location https://www.toptal.com/developers/gitignore/api/list | tr ',' '\n' | tee $__fish_complete_git_ignore_cache
    end
end

complete --command git --condition "__fish_seen_subcommand_from ignore" --no-files --arguments "(__fish_complete_git_ignore)"
