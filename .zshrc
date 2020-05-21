#------------------------------------------------------------------------------
# oh-my-zsh
#------------------------------------------------------------------------------
ZSH_THEME="agnoster"

plugins=(
	git 
	zsh-autosuggestions
	zsh-syntax-highlighting
)

ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#------------------------------------------------------------------------------
# export
#------------------------------------------------------------------------------

export PATH=$HOME/.nodebrew/current/bin:$HOME/go/bin:$PATH
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export GOPATH=$HOME/go
export AWS_DEFAULT_PROFILE=dev_user
export ZSH=$HOME/.oh-my-zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# added by Anaconda3 4.4.0 installer
export PATH="$HOME/anaconda/bin:$PATH"

export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"

export LANG=en_US.UTF-8
export EDITOR="vim"

#------------------------------------------------------------------------------
# gpg
#------------------------------------------------------------------------------
# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon)
fi

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------
alias ls='exa'
alias sl='exa'
alias l='exa -la'
alias ll='echo "(๑╹ω╹๑ ) ll => l"'
alias lt='exa -T'
alias relog='exec $SHELL -l'
alias his='history'
alias c='cd'
alias p='pwd'
alias t='type'
alias pbc='pbcopy'
alias pbp='pbpaste'

alias dk='docker'
alias dkc='docker-compose'
# alias gcl='gcloud'
alias kc='kubectl'
alias v='vim'
alias b='bat'
alias n='npm'
alias y='yarn'
alias dots='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'

alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcl='git clone'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcon='git config'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD~1..HEAD'
alias gf='git fetch'
alias gg='git grep'
alias gl='git graphLess' # see .gitconfig for "graphLess" definition
alias gll='git graph' # see .gitconfig for "graph" definition
alias gpl='git pull'
alias gps='git push'
alias grb='git rebase'
alias grs='git reset'
alias gs='git status'
alias gst='git stash'

alias bl='blueutil --power 1'
alias bll='blueutil --power 0'

# 一時的なaliasなので時が満ちたら消してください
alias gores='docker container prune -f && docker image prune -af && docker-compose up -d'
alias ddd='docker-compose down && docker-compose up -d && docker ps'

#------------------------------------------------------------------------------
# FASD & FZF
# - https://github.com/clvv/fasd
# - https://github.com/junegunn/fzf
# - https://github.com/anandpiyer/.dotfiles/blob/master/.zshrc
#------------------------------------------------------------------------------
eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
# export FZF_CTRL_T_OPTS="--select-1 --exit-0"
export FZF_COMPLETION_TRIGGER=''
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# fasd & fzf - jump using `fasd` if argument is given, filter output of `fasd`
# using `fzf` otherwise.
unalias j 2>/dev/null
j() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# fasd & fzf - use $EDITOR to edit file. Pick best matched file using `fasd`
# if argument given, else use `fzf` to filter `fasd` output.
unalias e 2>/dev/null
e() {
    [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && ${EDITOR} "${file}" || return 1
}

# fasd & fzf - open finder. If argument given, use `fasd` to pick the best match
# else use `fzf` to select from `fasd` results.
unalias o 2>/dev/null
o() {
    [ $# -gt 0 ] && fasd -a -e open "$*" && return
    local res
    res="$(fasd -Rla "$1" | fzf -1 -0 --no-sort +m)"
    if [[ -d "${res}" ]]; then
       open "${res}"
    else
       open "$(dirname "$res")"
    fi
}

#------------------------------------------------------------------------------

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(direnv hook zsh)"

# redefine prompt_context for hiding user@hostname
prompt_context() {}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/satouhitonari/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/satouhitonari/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/satouhitonari/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/satouhitonari/google-cloud-sdk/completion.zsh.inc'; fi
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
