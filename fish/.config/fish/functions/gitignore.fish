function gitignore
    curl -sL -o .gitignore (printf "https://gitignore.io/api/%s" (string join , $argv))
end
