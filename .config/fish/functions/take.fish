function take --description "Creates one or more directories, then `cd` into the last one."
    mkdir --parents -- $argv && cd -- $argv[-1]
end
