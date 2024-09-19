# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
plugins=(git docker pyenv golang zsh-syntax-highlighting zsh-autosuggestions)

# Add homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Enable oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Enable ASDF
source "$HOME/.asdf/asdf.sh"

# Enable pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Enable golang
export GOPATH=$(asdf where golang)/packages
export GOROOT=$(asdf where golang)/go
export PATH="${PATH}:$(go env GOPATH)/bin"
export GDK_HOME="$HOME/repos/gitlab-development-kit"

## GitLab Runner
alias gitlab-runner-start="docker run  -d --name gitlab-runner --add-host gdk.test:172.16.123.1 -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/repos/gitlab-development-kit/tmp/gitlab-runner:/etc/gitlab-runner gitlab/gitlab-runner"
alias gitlab-runner-stop="docker stop gitlab-runner && docker rm gitlab-runner"
# alias gitlab-runner="docker run --rm -it --add-host gdk.test:172.16.123.1 -v $GDK_HOME/tmp/gitlab-runner:/etc/gitlab-runner gitlab/gitlab-runner"

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


eval "$(zoxide init zsh)"
