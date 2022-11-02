# Dotfiles

Split into three directories:

- `desktop` and `framework`: for their eponymous platforms.
- `shared`: for both platforms. no need to stow from this directory as its contents are symlinked into both `desktop` and `framework`.

To install, in the directory for the platform:

```bash
stow -t ~ -v (find -maxdepth 1 -mindepth 1 -xtype d -not -name '.*' -printf '%P\n')
```
