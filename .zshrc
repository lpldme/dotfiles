#!/bin/zsh

unset LS_COLORS
unset LSCOLORS

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Basics                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS="$(uname | tr '[:upper:]' '[:lower:]')"

function __is_available {
  prog="${1}"
  os="${2}"

  if [ "$os" != "" ] && [ "${os}" != "${OS}"]
  then 
    return 1
  fi

  type "${prog}" > /dev/null
  return "$?"
}

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Exports                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export ZSH="$HOME/.oh-my-zsh"

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
export HISTSIZE="10000"
export HISTFILESIZE="20000"
export SAVEHIST="${HISTSIZE}"

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS

export EDITOR='nano'
export COLUMNS="80"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Programs & tools                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# SSH
export SSH_KEY_PATH="${HOME}/.ssh/id_ed25519"

# Pass 
export PASSWORD_STORE_DIR="${HOME}/cloud/library/pass"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# UV
__is_available uv \
&& eval "$(uv generate-shell-completion zsh)"

# FZF
__is_available fzf \
&& source <(fzf --zsh)

# OMZ
ZSH_THEME=""
plugins=(
  starship
)

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║${PATH}                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# Ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# Go
go -env -w GOPATH="${HOME}/.go"
export PATH="$(go env GOPATH)/bin:${PATH}"
export GOTELEMTRY="off"
export GOPROXY="direct"
export GOTOOLCHAIN="local"

# Cargo (Rust)
[ -d "${HOME}/.cargo/bin" ] \
&& export PATH="${HOME}/.cargo/bin:${PATH}"

[ -e "${HOME}/.cargo/env" ] \
&& source "${HOME}/.cargo.env"

# NPM
export NPM_PACKAGES="${HOME}/.local/lib/node_modules"
export PATH="${PATH}:${NPM_PACKAGES}/bin:${HOME}/.local/bin"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Completions                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# automatically load zsh completion functions
autoload -Uz compinit && compinit

WORDCHARS=''

unsetopt menu_complete		# do not autoselect the first completion entry
unsetopt flowcontrol		# disable ^S/^Q flow control
setopt auto_menu		# show completion menu on successive tab press
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
# ║ LIASES                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# https://github.com/eza-community/eza
__is_available eza \
&& alias l='eza -l' \
&& alias ls='eza -lg' \
&& alias ll='eza -la' \
&& alias la='eza -lahHgnuU' \
&& alias las='eza -las' 

# https://github.com/ajeetdsouza/zoxide
__is_available zoxide \
&& [ "${USER}" != "root" ] \
&& eval "$(zoxide init --cmd z zsh)" \
&& alias cdd=cdi

# https://github.com/sharkdp/bat
__is_available bat \
&& alias cat=bat

alias find='fd'

# https://github.com/aristocratos/btop
__is_available btop \
&& alias top='btop'

alias c='clear'

alias my-ip='curl http://ipecho.net/plain; echo'

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Git                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

alias ga='git add'
alias ga.='ga .'
alias gb='git branch'

alias gc='git commit --verbose'
alias gcs='git commit --gpg-sign'

alias gco='git checkout'
alias gcb='git checkout -b'
alias gcom='git checkout master'
alias gcod='git checkout dev'

alias gd='git diff'

alias gf='git fetch'

alias gpl='git pull --verbose'

alias grb='git rebase'

alias gm='git merge'

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ gh                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function gh() {
  export GITHUB_TOKEN="$(pass show github/token)"
  
  command gh $@
}

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Dotfiles management                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export DOTFILES="${HOME}/projects/@lpld/dotfiles"

function dotfiles-update-remote() {
	cp "${HOME}/.zshrc" "${DOTFILES}/.zshrc"

	rsync -avH \ 
	  --include-from="${DOTFILES}/.include" \
	  "${XDG_CONFIG_HOME}/" "${DOTFILES}/.config/" --delete-before

	mkdir -p "${DOTFILES}/usr/local/bin/"
  	rsync -avH \
    	  --include-from="${DOTFILES}/.include" \
    	  "/usr/local/" "${DOTFILES}/usr/local/"

	cargo install --list > "${DOTFILES}/cargo_install_--list"

	npm list -g --depth=0 > "${DOTFILES}/npm_list_-g_--depth_0"

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
	printf "Updating Rust tools ...\n"
  	cargo install-update -a -g

	printf "Updating macOS tools ...\n"
	brew update && brew upgrade

	printf "\nUpdating gh extensions ...\n"
	gh extension upgrade --all

	printf "Updating Zsh plugins ...\n"
	git -C ~/.zsh/zsh-autosuggestions pull

	printf "\nTools updated\n"
}

__is_available startship \
&& eval "$(starship init zsh)"
