autoload -U compinit promptinit
compinit
promptinit
autoload -U +X bashcompinit && bashcompinit
setopt nonomatch
export PATH="/usr/bin:/usr/local/bin:/usr/local/sbin:$PATH"
#export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

alias exa='exa --all'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias c='clear'
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
