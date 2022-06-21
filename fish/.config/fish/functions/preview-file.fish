function preview-file
    command man --local-file (pandoc --standalone --to man $argv | psub)
end
