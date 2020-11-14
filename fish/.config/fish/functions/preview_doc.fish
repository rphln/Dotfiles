function preview_doc
    command man --local-file (pandoc --standalone --to man $argv | psub)
end
