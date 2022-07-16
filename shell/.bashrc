#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
