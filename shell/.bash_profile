#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && . ~/.profile

export GPG_TTY=$(tty)

if [ -e /home/matt/.nix-profile/etc/profile.d/nix.sh ]; then . /home/matt/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
