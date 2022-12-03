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
if [[ -z "$TMUX" ]]; then
  tmux new-session
fi
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
