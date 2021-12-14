# Dotfiles

```bash
git submodule update --init --recursive
c++ scripts/.local/bin/show_time.cpp -o scripts/.local/bin/show_time
stow -v (find -maxdepth 1 -mindepth 1 -type d -not -name '.*' -printf '%P\n')
```
