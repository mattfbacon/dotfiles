#!/bin/sh

export BORG_REPO="ssh://support@mynfs:69//srv/backup"
echo -n 'passphrase: '
read BORG_PASSPHRASE
export BORG_PASSPHRASE

echo 'Starting backup'

borg create --verbose --filter AME --list --stats --show-rc --compression lzma --exclude-caches --exclude ~/.cache --exclude ~/dotfiles --exclude ~/.deja-dup --exclude ~/Documents/ISOs --exclude ~/.cargo --exclude ~/go --exclude ~/.npm --exclude ~/.rustup --exclude ~/.config/BraveSoftware/Brave-Browser --exclude ~/.local/lib --exclude ~/.local/share --exclude ~/.opam --exclude ~/.steam --exclude ~/.var --exclude ~/.vmodules ---exclude ~/.vpython-root --exclude ~/.themes --exclude ~/.cabal --exclude ~/.ghcup --exclude ~/.tack --exclude ~/.cpanm --exclude ~/.emscripten_cache --exclude ~/.surf ::'{hostname}-{now}' ~ || exit 1

echo 'Backup complete, starting prune'

borg prune --list --prefix '{hostname}-' --show-rc --keep-daily 7 --keep-weekly 4 --keep-monthly 6 || exit 1

echo 'Prune complete'
