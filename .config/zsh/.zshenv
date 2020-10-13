export LANG=en_US.UTF-8

# The startup files will not be run
# Doc: http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation
unsetopt GLOBAL_RCS

### PATH ###
typeset -gU PATH path
# Default
typeset -U path_default
path_default=(
    '/usr/local/bin'(N-/)
    '/usr/bin'(N-/)
    '/bin'(N-/)
    '/usr/local/sbin'(N-/)
    '/usr/sbin'(N-/)
    '/sbin'(N-/)
)
path=("${path_default[@]}")
path=(
    "${HOME}/.linuxbrew/bin"
    "${HOME}/.local/bin"
    "${path[@]}"
)
 
manpath=(
    "${HOME}/.linuxbrew/share/man"
    "${manpath[@]}"
)

ld_library_path=(
    "${HOME}/.linuxbrew/lib"
    "${ld_library_path[@]}"
)

infopath=(
    "${HOME}/.linuxbrew/share/info"
    "${infopath[@]}"
)


### XDG Base Directory ###
# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"${HOME}/.cache"}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-"/tmp/runtime-$(id -u)"}"
if [[ ! -d "${XDG_RUNTIME_DIR}" ]]; then
    command mkdir -m 700 -p -- "${XDG_RUNTIME_DIR}"
fi

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export PATH="/usr/local/texlive/2020/bin/x86_64-darwin:$PATH"

export PATH=$HOME/.nodebrew/current/bin:$PATH
