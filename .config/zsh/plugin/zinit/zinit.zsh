declare -A ZINT
ZINT[HOME_DIR]="${XDG_DATA_HOME}/zsh/plugin/zinit"
### Added by Zinit's installer

# Auto install
if [[ ! -f "${ZINT[HOME_DIR]}/bin/zinit.zsh" ]]; then
    echo 'Install Zinit'
    git clone 'https://github.com/zdharma/zinit' "${ZINT[HOME_DIR]}/bin"
    . "${ZINT[HOME_DIR]}/bin/zinit.zsh"
    zinit self-update
fi

. "${ZINT[HOME_DIR]}/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

alias zinit-update='zinit update && zinit self-update && zinit compile'
### End of Zinit installer's chunk
zinit ice wait'0' lucid
zinit light zdharma/fast-syntax-highlighting
zinit ice wait'0' lucid
zinit light chrissicool/zsh-256color
zinit ice wait'0' lucid
zinit light zsh-users/zsh-autosuggestions 
zinit ice wait'1' lucid \
    atclone'dircolors -b dircolors.256dark > color.zsh' \
    atpull'%atclone' \
    pick'color.zsh'
zinit light 'seebi/dircolors-solarized'
