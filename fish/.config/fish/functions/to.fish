function to
    for target in $argv
        mkdir --parents -- (dirname $target) && touch -- $target
    end
end
