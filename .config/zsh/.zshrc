autoload -U compinit promptinit
compinit
promptinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"
setopt nonomatch
export PATH="/usr/bin:/usr/local/bin:/usr/local/sbin:${HOME}/Library/Python/3.7/bin:${HOME}/Library/Application Support/Code/User/globalStorage/haskell.haskell:$PATH"
#export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

alias exa='exa --all'
# powerline setting for wsl
#powerline-daemon -q
#. /home/linuxbrew/.linuxbrew/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
# powerline setting for mac
function powerline_precmd() {
    PS1="$(/usr/local/bin/powerline-go -error $? -shell zsh)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
if [[ -z "$TMUX" ]]; then
  tmux new-session
fi
### Zinit ###
# Repo: https://github.com/zdharma/zinit
. "${XDG_CONFIG_HOME}/zsh/plugin/zinit/zinit.zsh"


