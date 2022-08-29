function prompt-directory --description "Prints the last two path components from `prompt_pwd`."
    string match --regex '(?:^/)?(?:[^/]+/?){0,2}$' (prompt_pwd --dir-length 0)
end
