function mkcd
    mkdir --parents -- $argv && cd -- $argv[-1]
end
