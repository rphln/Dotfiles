function preview-file
    command man --local-file (pandoc --standalone --sandbox --to man $argv | psub)
end
