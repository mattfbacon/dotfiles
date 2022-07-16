# Dotfiles

```bash
git submodule update --init --recursive
stow -v (find -maxdepth 1 -mindepth 1 -type d -not -name '.*' -printf '%P\n')
```
