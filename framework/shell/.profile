# ~/.profile

source ~/.setvars

eval "$(pyenv init --path)"

eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh 2>/dev/null)
export GNOME_KEYRING_CONTROL
export SSH_AUTH_SOCK
