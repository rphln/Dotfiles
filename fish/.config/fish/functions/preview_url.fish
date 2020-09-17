function preview_url
  preview_doc --from html (curl --silent --location $argv | psub)
end
