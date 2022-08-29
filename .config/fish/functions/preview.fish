function preview
    command man --local-file (pandoc --standalone --sandbox --to man $argv | psub)
end
