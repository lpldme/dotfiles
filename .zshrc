#!/bin/zsh

unset LS_COLORS
unset LSCOLORS

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Basi  s                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS="$(uname | tr '[:upper:]' '[:lower:]')"

function __is_available {
  prog="${1}"
  os="${2}"

  if [ "$os" != "" ] && [ "${os}" != "${OS}" ]
  then
    return 1
  fi

  type "${prog}" > /dev/null
  return "$?"
}

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Expor  s                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export ZSH="$HOME/.oh-my-zsh"

export EDITOR='nano'
export LANG="en_US.UTF-8"

export HOMEBREW_PREFIX="/opt/homebrew"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1

# https://specifications.freedesktop.org/basedir/latest/
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DOWNLOAD_DIR="${HOME}/downloads"
export XDG_DESKTOP_DIR="${HOME}/desktop"
export XDG_PUBLICSHARE_DIR="${HOME}/shared/public"
export XDG_DOCUMENTS_DIR="${HOME}/cloud/documents"
export XDG_PICTURES_DIR="${HOME}/cloud/photos"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ General confi g                                                            ║
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
# ║ Programs & tool s                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# SSH
export SSH_KEY_PATH="${HOME}/.ssh/id_ed25519"

# Pass
export PASSWORD_STORE_DIR="${HOME}/cloud/library/pass"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# OMZ
ZSH_THEME=""
plugins=(
 starship
)

# IPFS
export IPFS_PATH="${HOME}/.ipfs"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║${PATH }                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# Python
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"

[ -e "${HOME}/.local/share/pyenv/bin/activate" ] \
&& source "${HOME}/.local/share/pyenv/bin/activate"

# Ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# Go
#go -env -w GOPATH="${HOME}/.go"
export PATH="$(go env GOPATH)/bin:${PATH}"
export GOTELEMTRY="off"
export GOPROXY="direct"
export GOTOOLCHAIN="local"

# Cargo (Rust)
[ -d "${HOME}/.cargo/bin" ] \
&& export PATH="${HOME}/.cargo/bin:${PATH}"

#[ -e "${HOME}/.cargo/env" ] \
#&& source "${HOME}/.cargo.env"

# NPM
export NPM_PACKAGES="${HOME}/.local/lib/node_modules"
export PATH="${PATH}:${NPM_PACKAGES}/bin:${HOME}/.local/bin"

# NymVPN
# export PATH="${PATH}:${HOME}/nym-vpn-client/nym-vpn-core/target/debug"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Completion s                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# automatically load zsh completion functions
autoload -Uz compinit && compinit zrecompile

if [[ -z "$ZSH_COMPDUMP" ]]; then
  ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

WORDCHARS=''

# do not autoselect the first completion entry
unsetopt menu_complete

# disable ^S/^Q flow control
unsetopt flowcontrol

# show completion menu on successive tab press
setopt auto_menu

# setopt complete_in_word
# setopt always_to_end

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# https://docs.astral.sh/uv/getting-started/installation/#__tabbed_3_2
__is_available uv \
&& eval "$(uv generate-shell-completion zsh)" \
&& eval "$(uvx --generate-shell-completion zsh)"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║Autosuggestion s                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGESTIONS="${HOME}/.zsh/zsh-autosuggestions"
ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${HOST}"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ GP G                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export GPG_TTY=$TTY

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ SS H                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝



# ╔════════════════════════════════════════════════════════════════════════════╗
# ║A LIAS S                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# https://github.com/eza-community/eza
__is_available eza \
&& alias ls='eza  --time-style=relative --git --octal-permissions --icons \
  --color=auto --binary -lg' \
&& alias ll='eza  --time-style=long-iso --git --octal-permissions --icons \
  --color=auto --binary -la' \
&& alias la='eza  --time-style=long-iso --git --octal-permissions         \
  --color=auto --binary --changed -lahHgnuU' \
&& alias l='eza   --time-style=long-iso --git                     --icons \
  --color=auto --binary -l --no-time' \
&& alias lls='eza --time-style=long-iso --git --octal-permissions --icons \
  --color=auto --binary -las modified' \
#&& alias l='eza -l' \
#&& alias ls='eza -lg' \
#&& alias ll='eza -la' \
#&& alias la='eza -lahHgnuU' \
#&& alias las='eza -las' \


# https://github.com/ajeetdsouza/zoxide
__is_available zoxide \
&& [ "${USER}" != "root" ] \
&& eval "$(zoxide init --cmd z zsh)" \
&& alias cdd=cdi

# https://github.com/sharkdp/bat
__is_available bat \
&& alias cat=bat

# https://github.com/aristocratos/btop
__is_available btop \
&& alias top='btop'

# https://github.com/neovim/neovim
__is_available nvim \
&& alias vi=nvim \
&& alias vim=nvim \

# https://github.com/junegunn/fzf
__is_available fzf \
&& alias preview='fzf --preview="bat {} --color=always"'

__is_available xdg-open linux \
&& alias open='xdg-open'

alias c='clear'
alias wget='wget --no-hsts'
alias my-ip='curl http://ipecho.net/plain; echo'

# Journal
export JRNL="${HOME}/projects/@lpld/leo-sg.com/content"
alias jrnl="cd ${JRNL}"
alias bookmark="git -C ${JRNL} checkout dev \
  && nano ${JRNL}/bookmarks/index.md \
  && git -C ${JRNL} add bookmarks \
  && git -C ${JRNL} commit -S"

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

	/bin/ls -1 ~/.go/bin/ \
    	  | while read -r bin; \
    	  do go version -m "${HOME}/.go/bin/${bin}" \
    	  | grep '^[[:space:]]path' \
    	  | awk '{ print $2 }' \
    	  | grep '^github.com' \
    	  | sort \
    	  | uniq;\
    	  done > "${DOTFILES}/go_list_github-com"

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

	printf "\nUpdating Go tools ...\n"
 	unset GOPROXY
  	  /bin/ls -1 ~/.go/bin/ \
    	  | while read -r bin; do go version -m "${HOME}/.go/bin/${bin}" \
    	  | grep '^[[:space:]]path' \
    	  | awk '{ print $2 }' \
    	  | grep '^github.com' \
    	  | sort \
    	  | uniq \
    	  | xargs -I{} go install {}@latest; done

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

source "$ZSH/oh-my-zsh.sh"
