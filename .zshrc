# minimal zsh prompt
export PS1="%B%~ $%b "

# locale
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# larger history
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

# Move cursor word-by-word with Option+arrow keys
bindkey '^[f' forward-word      # Option + right arrow
bindkey '^[b' backward-word     # Option + left arrow

# Delete words with Option+Delete
bindkey '^[^?' backward-kill-word

# default editor
alias vim="nvim"
export EDITOR="cursor -w"

# ls colored output
alias ls="ls -G"

# ducks
alias ducks="du -sh * | sort -hr | head"

# brew
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH
fpath[1,0]="/opt/homebrew/share/zsh/site-functions";

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun
[ -s "/Users/mark/.bun/_bun" ] && source "/Users/mark/.bun/_bun"

# n
export N_PREFIX=$HOME/n
export PATH=$N_PREFIX/bin:$PATH

# go
export PATH=$(go env GOPATH)/bin:$PATH

# uv
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$PATH
export UV_PYTHON_PREFERENCE="only-managed"

# postgres
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Initialize Zsh completion system
autoload -Uz compinit
compinit
