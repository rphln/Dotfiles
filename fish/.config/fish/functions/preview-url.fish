function preview-url
    preview --from html (curl --silent --location $argv | psub)
end
