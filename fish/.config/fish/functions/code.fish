function code
    if test -n $DISPLAY
        vscodium $argv
    else
        nvim $argv
    end
end
