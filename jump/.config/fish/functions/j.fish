function j
    set --local target (jump query $argv)

    if [ -n "$target" ]
        printf "%s→%s %s\n" (set_color green) (set_color normal) $target
        cd -- "$target"
    else
        echo >&2 "The query `$argv` did not yield any results."
        return 1
    end
end
