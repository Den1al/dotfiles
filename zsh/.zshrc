# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR=/opt/homebrew/bin/nvim
export PATH="$PATH:$HOME/scripts:$HOME/.lmstudio/bin"

# Docker CLI completions (fpath must be set before compinit/OMZ)
fpath=($HOME/.docker/completions $fpath)

# Lazy Java home - only set if java_home exists
if [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
fi
# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable automatic updates
zstyle ':omz:update' mode disabled  # disable automatic updates

# Plugins (pyenv removed - manually initialized below)
plugins=(tmux git docker golang zsh-autosuggestions zsh-syntax-highlighting)


export ZSH_TMUX_AUTOSTART=true

# Add homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Enable oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Enable ASDF
# source "$HOME/.asdf/asdf.sh"

# Enable pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Enable golang
# export GOPATH=$(asdf where golang)/packages
# export GOROOT=$(asdf where golang)/go
# export PATH="${PATH}:$(go env GOPATH)/bin"
# export GDK_HOME="$HOME/repos/gitlab-development-kit"

## GitLab Runner
alias gitlab-runner-start="docker run  -d --name gitlab-runner --add-host gdk.test:172.16.123.1 -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/repos/gitlab-development-kit/tmp/gitlab-runner:/etc/gitlab-runner gitlab/gitlab-runner"
alias gitlab-runner-stop="docker stop gitlab-runner && docker rm gitlab-runner"
# alias gitlab-runner="docker run --rm -it --add-host gdk.test:172.16.123.1 -v $GDK_HOME/tmp/gitlab-runner:/etc/gitlab-runner gitlab/gitlab-runner"

# TMUX
alias tm="$HOME/.config/wezterm/start-tmux.sh"

# NVIM
alias vim=nvim
alias v=nvim

# Rust
. "$HOME/.cargo/env"


# Eza
alias ll='eza -l -F=always --color=always --icons=always --all --octal-permissions --git --sort=modified --reverse'
alias l='eza -l -F=always --color=always --icons=always --all --octal-permissions --git'


# Tmuxifier (lazy-loaded - only init when first used)
export PATH="$HOME/.tmuxifier/bin:$PATH"
tmuxifier() {
  unfunction tmuxifier
  eval "$(command tmuxifier init -)"
  tmuxifier "$@"
}

# Gitlab Duo (use zsh native file reading, avoid cat subshells)
[[ -r "$HOME/.config/gitlab-duo/key" ]] && export GITLAB_TOKEN=$(<"$HOME/.config/gitlab-duo/key")
[[ -r "$HOME/.config/gitlab-duo/a-key" ]] && export ANTHROPIC_TOKEN=$(<"$HOME/.config/gitlab-duo/a-key") && export ANTHROPIC_API_KEY=$(<"$HOME/.config/gitlab-duo/a-key")
# Propagate to launchd so GUI apps (e.g. Hammerspoon) can access it via os.getenv
[[ -n "$ANTHROPIC_API_KEY" ]] && launchctl setenv ANTHROPIC_API_KEY "$ANTHROPIC_API_KEY"


# FZF
source <(fzf --zsh)

# Obsidian
alias oo="cd '$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain'"

# Lazygit
alias lg="lazygit"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# opam configuration (OCaml)
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# mise (runtime version manager) - replaces asdf/pyenv for some tools
eval "$(/opt/homebrew/bin/mise activate zsh)"

# claude
alias claude="~/.claude/local/claude"
alias cc="claude --dangerously-skip-permissions"

# Local bin
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
