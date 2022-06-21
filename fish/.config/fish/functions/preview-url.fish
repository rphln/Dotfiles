function preview-url
    preview-file --from html (curl --silent --location $argv | psub)
end
