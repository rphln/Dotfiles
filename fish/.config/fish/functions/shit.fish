function shit --description "Executes the previous command with `sudo`."
    sudo -E fish -c $history[1]
end
