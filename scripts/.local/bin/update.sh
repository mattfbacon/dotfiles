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
nvm install node
nvm use node

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
