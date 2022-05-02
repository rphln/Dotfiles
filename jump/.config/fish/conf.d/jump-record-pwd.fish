function jump-record-pwd --on-variable PWD
    if [ ! -f ~/.cache/jump.sqlite3 ]
        jump --database ~/.cache/jump.sqlite3 init
    end

    jump --database ~/.cache/jump.sqlite3 record "$PWD"
end
