# virtualenvwarpper exports
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code

# make sure pip uses the same base dir as virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

# pew doesn't prepend virtualenv to prompt by default
prepend_prompt() {
    local black=""
    local blue=""
    local bold=""
    local cyan=""
    local green=""
    local orange=""
    local purple=""
    local red=""
    local reset=""
    local white=""
    local yellow=""

    local hostStyle=""
    local userStyle=""

    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        tput sgr0 # reset colors

        bold=$(tput bold)
        reset=$(tput sgr0)

        # Solarized colors
        # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 64)
        orange=$(tput setaf 166)
        purple=$(tput setaf 125)
        red=$(tput setaf 124)
        white=$(tput setaf 15)
        yellow=$(tput setaf 136)
    else
        bold=""
        reset="\e[0m"

        black="\e[1;30m"
        blue="\e[1;34m"
        cyan="\e[1;36m"
        green="\e[1;32m"
        orange="\e[1;33m"
        purple="\e[1;35m"
        red="\e[1;31m"
        white="\e[1;37m"
        yellow="\e[1;33m"
    fi

    if [[ ! -z $VIRTUAL_ENV ]]; then
        PS1="\[$reset$white\]$PS1"
        PS1="\[$blue\](\${VIRTUAL_ENV##*/})$PS1"
        PS1="\n$PS1"
    fi

    export PS1
}

prepend_prompt

# in case we launch a new terminal in a directory with a
# .venv file, check immediately
check_virtualenv

