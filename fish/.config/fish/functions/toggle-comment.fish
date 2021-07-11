function toggle-comment
    commandline (commandline --current-process | perl -pe 's/(^# *)|(?!^#)/$1 ? "" : "# "/e')
end
