autoload -U compinit promptinit
compinit
promptinit
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

alias exa='exa --all'
# powerline setting for wsl
powerline-daemon -q
. /home/linuxbrew/.linuxbrew/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
# powerline setting for mac
# powerline-daemon -q
#. /usr/local/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
if [[ -z "$TMUX" ]]; then
  tmux new-session
  exit
fi
cd
### Zinit ###
# Repo: https://github.com/zdharma/zinit
. "${XDG_CONFIG_HOME}/zsh/plugin/zinit/zinit.zsh"


