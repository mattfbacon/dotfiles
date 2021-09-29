# Dotfiles

```bash
$CXX scripts/.local/bin/show_time.cpp -o scripts/.local/bin/show_time
find -maxdepth 1 -mindepth 1 -type d -not -name '.*' -exec stow -v {} \+
```
