# ~/.profile

source ~/.setvars

eval "$(pyenv init --path)"

eval $(/usr/bin/gnome-keyring-daemon --replace --components=pkcs11,secrets,ssh 2>/dev/null)
export SSH_AUTH_SOCK

