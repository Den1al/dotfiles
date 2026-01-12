
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Powerlevel1k
source ~/powerlevel10k/powerlevel10k.zsh-theme

export EDITOR=vim
export JAVA_HOME=$(/usr/libexec/java_home -v1.7)
# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable automatic updates
zstyle ':omz:update' mode disabled  # disable automatic updates

# Plugins
plugins=(tmux git docker pyenv golang zsh-syntax-highlighting zsh-autosuggestions poetry)


export ZSH_TMUX_AUTOSTART=true

# Add homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Enable oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Enable ASDF
# source "$HOME/.asdf/asdf.sh"

# Enable MISE
eval "$(mise activate zsh)"

# Enable pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Enable golang
export GDK_HOME="$HOME/repos/gitlab-development-kit"

# TMUX
alias tm="$HOME/.config/wezterm/start-tmux.sh"

# NVIM
alias vim=nvim

# Rust
. "$HOME/.cargo/env"


# Eza 
alias ll='eza -l -F=always --color=always --icons=always --all --octal-permissions --git --sort=modified --reverse'
alias l='eza -l -F=always --color=always --icons=always --all --octal-permissions --git'


# Tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Gitlab Duo
export GITLAB_TOKEN=$(cat "$HOME/.config/gitlab-duo/key")
export ANTHROPIC_TOKEN=$(cat "$HOME/.config/gitlab-duo/a-key")
export ANTHROPIC_API_KEY=$(cat "$HOME/.config/gitlab-duo/a-key")


# FZF
source <(fzf --zsh)

# Obsidian
alias oo="cd '$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain'"

# Lazygit
alias lg="lazygit"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh. 
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '$HOME/.opam/opam-init/init.zsh' ]] || source '$HOME/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

alias lala='ssh -t hstgr "cd ~/mgmt; tree . -L 2; zsh --login;"'
alias lala2='ssh -t hstgr-big'
alias sp="python -c 'import site;print(\"\n\".join(site.getsitepackages()))'"

eval "$(zoxide init zsh)"


