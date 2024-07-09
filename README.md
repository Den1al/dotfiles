# ✨ My dotfiles ✨

> Current Stack

- kitty
- tmux
- neovim

### Install with stow:

```bash
stow --target .

# Edit $HOME/.zprofile
source $HOME/.config/zsh/.zshrc
```

### Homebrew installation:

```bash
# Leaving a machine
brew leaves > homebrew/leaves.txt

# Fresh installation
xargs brew install < homebrew/leaves.txt
```

### Uninstall with stow:

```bash
stow --delete .
```

### Refresh Stow

```bash
./refresh.sh
```
