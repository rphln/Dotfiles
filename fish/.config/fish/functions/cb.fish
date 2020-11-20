function cb
    printf '\e]52;c;%s;\a' (string join \n $argv | perl -pe 'chomp if eof' | base64 --wrap 0)
end
