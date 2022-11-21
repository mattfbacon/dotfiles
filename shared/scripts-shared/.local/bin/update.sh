#!/bin/fish
echo -----------
echo pacman
echo -----------
paru

echo -----------
echo rust
echo -----------
rustup update

echo -----------
echo npm
echo -----------
npm --global upgrade

echo -----------
echo yarn
echo -----------
yarn global upgrade

echo -n '(Press any key to exit)'
read -p ''
