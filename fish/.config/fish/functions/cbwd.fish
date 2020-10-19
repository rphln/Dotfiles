function cbwd
    printf '\e]52;c;%s;\a' (pwd | perl -pe 'chomp if eof' | base64)
end
