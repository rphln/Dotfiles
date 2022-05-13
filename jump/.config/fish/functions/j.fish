function j
    set --local target (jump query $argv)

    if [ -n "$target" ]
        cd -- "$target"
    else
        printf >&2 "The query `%s` did not yield any results.\n" {$argv}
        return 1
    end
end
