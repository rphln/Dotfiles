function yank --description "Pipes a value into the clipboard."
    perl -pe 'chomp if eof' -- $argv | if type --query pbcopy
        pbcopy
    else if type --query wl-copy && set --query WAYLAND_DISPLAY
        wl-copy
    else if type --query xsel && set --query DISPLAY
        xsel --input --clipboard
    else if type --query xclip && set --query DISPLAY
        xclip -selection clipboard
    else if type --query clip.exe
        clip.exe
    else
        base64 --wrap 0 | xargs printf '\e]52;c;%s;\a'
    end
end
