function preview
    command man --local-file (pandoc --standalone --to man $argv | psub)
end
