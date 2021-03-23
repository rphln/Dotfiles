function yank-command --description "Copies the current command line to the clipboard."
    commandline -b | yank
end
