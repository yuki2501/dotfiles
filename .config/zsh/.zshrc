autoload -U compinit promptinit
compinit
promptinit
autoload -U +X bashcompinit && bashcompinit
setopt nonomatch
export PATH="/usr/bin:/usr/local/bin:/usr/local/sbin:$HOME/.ghcup/bin:$HOME/.pub-cache/bin:$HOME/fvm/default/bin:$PATH"
#export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

alias exa='exa --all'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias c='clear'
alias fs='git branch | fzf | xargs git switch'
alias cdc='cd && clear'
alias fzc='exa -F| grep -v /|  fzf --select-1 | xargs bat'
alias fsi='dotnet fsi'
alias ffc='fzf | xargs cat | pbcopy'
alias nzi='zi && nvim'
alias wet='curl wttr.in/Sendai'
if [[ -z "$TMUX" ]]; then
  tmux new-session
fi

function _left-pane() {
  tmux select-pane -L
}
zle -N left-pane _left-pane

function _down-pane() {
  tmux select-pane -D
}
zle -N down-pane _down-pane

function _up-pane() {
  tmux select-pane -U
}
zle -N up-pane _up-pane

function _right-pane() {
  tmux select-pane -R
}
zle -N right-pane _right-pane

function _backspace-or-left-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle backward-delete-char
  elif [[ ! -z ${TMUX} ]]; then
    zle left-pane
  fi
}
zle -N backspace-or-left-pane _backspace-or-left-pane

function _kill-line-or-up-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle kill-line
  elif [[ ! -z ${TMUX} ]]; then
    zle up-pane
  fi
}
zle -N kill-line-or-up-pane _kill-line-or-up-pane

function _accept-line-or-down-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle accept-line
  elif [[ ! -z ${TMUX} ]]; then
    zle down-pane
  fi
}
zle -N accept-line-or-down-pane _accept-line-or-down-pane

bindkey '^k' kill-line-or-up-pane
bindkey '^l' right-pane
bindkey '^h' backspace-or-left-pane
bindkey '^j' accept-line-or-down-pane


### Zinit ###
# Repo: https://github.com/zdharma/zinit
. "${XDG_CONFIG_HOME}/zsh/plugin/zinit/zinit.zsh"


export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

### starship ###
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)" 
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/mpv-iina/bin:$PATH"

# pyenvの設定
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - zsh)"

# opam configuration
[[ ! -r /Users/yuki/.opam/opam-init/init.zsh ]] || source /Users/yuki/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
export PATH="/usr/local/opt/openjdk/bin:$PATH"


autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line


export ZENO_GIT_CAT="bat"
bindkey '^m' zeno-auto-snippet-and-accept-line

bindkey '^i' zeno-completion
bindkey '^x' zeno-insert-snippet

bindkey '^x '  zeno-insert-space
bindkey '^x^m' accept-line
bindkey '^x^z' zeno-toggle-auto-snippet

export PATH="/Applications/Coq-Platform~8.16~2022.09~beta1.app/Contents/Resources/bin:$PATH"
eval "$(direnv hook zsh)"
