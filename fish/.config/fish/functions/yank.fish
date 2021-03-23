function yank --description "Pipes a value into the clipboard."
    perl -pe 'chomp if eof' | base64 --wrap 0 | xargs printf '\e]52;c;%s;\a'
end
