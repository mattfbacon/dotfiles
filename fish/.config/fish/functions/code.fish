function code
    if test -n $DISPLAY
        vscodium --ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer $argv
    else
        nvim $argv
    end
end
