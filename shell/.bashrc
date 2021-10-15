#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# if [ "$TERM" = "linux" ]; then
#   echo -e "\e]P03b3228
#   \e]P1cb6077
#   \e]P2beb55b
#   \e]P3f4bc87
#   \e]P48ab3b5
#   \e]P5a89bb9
#   \e]P67bbda4
#   \e]P7d0c8c6
#   \e]P87e705a
#   \e]P9cb6077
#   \e]PAbeb55b
#   \e]PBf4bc87
#   \e]PC8ab3b5
#   \e]PDa89bb9
#   \e]PE7bbda4
#   \e]PFf5eeeb"
# fi

shopt -q login_shell && ssh-add

shopt -q login_shell || test "$fish_subprocess" == 1 || [[ $(realpath $(which $(ps -o command= $(ps -o ppid= $$) | tr ' ' '\n' | head --lines 1))) == "/usr/bin/fish" ]] || exec fish

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
case "$TERM" in
xterm*|rxvt*)
    # Custom bash prompt via kirsle.net/wizards/ps1.html
    # export PS1="\[$(tput setaf 4)\]\s!\[$(tput bold)\]\[$(tput setaf 6)\]\u\[$(tput sgr0)\]:[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]] \\$\[$(tput sgr0)\] "
    eval "$(starship init bash)"
    ;;
*)
    ;;
esac

alias rm="rm -I --preserve-root"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias syu="sudo pacman -Syu"
alias wget="wget -c"
alias sy="systemctl"
