#!/bin/fish
echo -----------
echo pacman
echo -----------
yay

echo -----------
echo rust
echo -----------
rustup update

echo -----------
echo nvm
echo -----------
nvm install latest
nvm use latest

echo -n '(Press any key to exit)'
read -p ''
