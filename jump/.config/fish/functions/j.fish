function j
    set --local target (jump query $argv)

    if [ -n "$target" ]
        cd -- "$target"
    else
        echo >&2 "The query `$argv` did not yield any results."
        return 1
    end
end
