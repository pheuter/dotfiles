# locality
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# ls colored output
alias ls="ls -G"

# bat
alias cat="bat"

# arm64 neovim
alias vim="nvim"

# vscode exploration
alias code="code-exploration"

# editor
export EDITOR=nvim

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	vim "$file"
}
bindkey -s '^f' 'rga-fzf\n'

# arm64 homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# completion
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*:*:*:*:*' menu select

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git/git-completion.bash
fpath+=$HOME/.zsh/git

# pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# brew completions
fpath+=$(brew --prefix)/share/zsh/site-functions

# load all zsh completions, setup fpaths before this
autoload -Uz compinit && compinit

# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# direnv
eval "$(direnv hook zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
