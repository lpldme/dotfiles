#!/bin/zsh

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Basics                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS="$(uname | tr '[:upper:]' '[:lower:]')"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Exports                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export EDITOR='nano'
export LANG="en_US.UTF-8"

export HOMEBREW_PREFIX="/opt/homebrew"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"

export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DOWNLOAD_DIR="${HOME}/downloads"
export XDG_DESKTOP_DIR="${HOME}/desktop"
export XDG_PUBLICSHARE_DIR="${HOME}/shared/public"
export XDG_DOCUMENTS_DIR="${HOME}/cloud/documents"
export XDG_PICTURES_DIR="${HOME}/cloud/photos"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ General config                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export HISTFILE="${HOME}/.zsh_history"
export HISTCONTROL="ignoredups:ignorespace"
export HISTSIZE="100000"
export HISTFILESIZE="200000"
export SAVEHIST="${HISTSIZE}"
setopt EXTENDED_HISTORY

export EDITOR='nano'
export COLUMNS="80"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Programs & tools                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export SSH_KEY_PATH="${HOME}/.ssh/id_ed25519"

# Pass 
export PASSWORD_STORE_DIR="${HOME}/cloud/library/pass"

# Zoxide
eval "$(zoxide init zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# UV
eval "$(uv generate-shell-completion zsh)"

# FZF
source <(fzf --zsh)

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ${PATH}                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝



# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Completions                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

autoload -U compaudit compinit

# unsetopt menu_complete   # do not autoselect the first completion entry
# unsetopt flowcontrol
# setopt auto_menu         # show completion menu on successive tab press
# setopt complete_in_word
# setopt always_to_end

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Autosuggestions                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGESTIONS="${HOME}/.zsh/zsh-autosuggestions"
ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${HOST}"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ GPG                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export GPG_TTY=$TTY

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ SSH                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝



# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ALIASES                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

alias l="eza -l"
alias ls="eza -lg"
alias ll="eza -la"
alias la="eza -lahHgnuU"
alias las="eza -las"
alias z="zoxide"
alias cat="bat"
alias find="fd"
alias c="clear"
alias my-ip="curl http://ipecho.net/plain; echo"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Git                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

alias ga='git add'
alias gb='git branch'
alias gc='git commit --verbose'
alias gcs='git commit --gpg-sign'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git pull'
alias grb='git rebase'
alias gm='git merge'

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Dotfiles management                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export DOTFILES="${HOME}/projects/@lpldme/dotfiles"

function dotfiles-update-remote() {
	cp "${HOME}/.zshrc" "${DOTFILES}/.zshrc"

	# mkdir -p "${DOTFILES}/usr/local/bin/"
  	# rsync -avH \
    	#   --include-from="${DOTFILES}/.include" \
    	#   "/usr/local/" "${DOTFILES}/usr/local/"

	gh extension list > "${DOTFILES}/gh_extension_list"

	git -C "${DOTFILES}" commit -a -S
	return 0
}

function dotfiles-update-local() {
	printf "are you sure? (y/n) "
	read -r confirmation

	[ "${confirmation}" != "y" ] && return 1

	cp "${DOTFILES}/.zshrc" "${HOME}/.zshrc"
 	
	rsync -avH \
    	  --include-from="${DOTFILES}/.include" \
    	  "${DOTFILES}/.config/" "${XDG_CONFIG_HOME}/"
	
	cp "${DOTFILES}/usr/local/bin/"* /usr/local/bin/

  	return 0
}

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ update-tools                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function update-tools() {
	printf "Updating macOS tools ...\n"
	brew update && brew upgrade

	printf "\nUpdating gh extensions ...\n"
	gh extension upgrade --all

	printf "Updating Zsh plugins ...\n"
	git -C ~/.zsh/zsh-autosuggestions pull
	#git -C ~/.zsh/zsh-autocompletions

	printf "\nTools updated\n"
}

eval "$(starship init zsh)"
