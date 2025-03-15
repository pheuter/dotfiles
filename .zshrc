# locale
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# larger history
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

# minimal zsh prompt
export PS1="%B%~ $%b "

# default editor
alias vim="nvim"
export EDITOR="nvim"

# ls colored output
alias ls="ls -G"

# ducks
alias ducks="du -sh * | sort -hr | head"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# dotnet
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# go
export PATH=$PATH:$(go env GOPATH)/bin

# uv
. "$HOME/.cargo/env"
eval "$(uv generate-shell-completion zsh)"
export UV_PYTHON_PREFERENCE="only-managed"

# postgres
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Move cursor word-by-word with Option+arrow keys
bindkey '^[f' forward-word      # Option + right arrow
bindkey '^[b' backward-word     # Option + left arrow

# Delete words with Option+Delete
bindkey '^[^?' backward-kill-word
