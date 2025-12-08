export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
ENABLE_CORRECTION="true"

plugins=(
	git
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nano'

# Homebrew
export HOMEBREW_PREFIX="/opt/homebrew"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"

# Python
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"

# Docker with Colima
# export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"
# export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"

alias l="eza"
alias ll="eza -l"
alias la="eza -a"
alias cat="bat"
alias find="fd"
alias o="open ."
alias c="clear"
alias ip="ifconfig -l | xargs -n1 ipconfig getifaddr"
alias tldr="tealdeer"

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if [ -r ~/.zshrc ]; then echo -e '\nexport GPG_TTY=$(tty)' >> ~/.zshrc; \
  else echo -e '\nexport GPG_TTY=$(tty)' >> ~/.zprofile; fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(uv generate-shell-completion zsh)"

export GPG_TTY=$(tty)
