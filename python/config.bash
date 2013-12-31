# virtualenvwarpper exports
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
source /usr/local/bin/virtualenvwrapper.sh

#export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
#source /usr/local/bin/virtualenvwrapper_lazy.sh

# make sure pip uses the same base dir as virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

# Call virtualenvwrapper's "workon" if .venv exists.
# adapted from--
# https://gist.github.com/clneagu/7990272
# which is modified from--
# http://justinlilly.com/python/virtualenv_wrapper_helper.html
# which is linked from--
# http://virtualenvwrapper.readthedocs.org/en/latest/tips.html#automatically-run-workon-when-entering-a-directory
check_virtualenv() {
    if [ -e .venv ]; then
        env=`cat .venv`
        if [[ "$env" != "${VIRTUAL_ENV##*/}" &&  $(workon | grep -e "^${env}$") ]]; then
            workon $env
        fi
    fi
}

venv_cd () {
    builtin cd "$@" && check_virtualenv
}

# Call check_virtualenv in case opening directly into a directory (e.g
# when opening a new tab in Terminal.app).
check_virtualenv
