function preview_doc
  man --local-file (pandoc --standalone --to man $argv | psub)
end
