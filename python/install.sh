#!/bin/bash
#
# Python
#
# This will install the latest python 2.x branch via
# Homebrew, install virtualenv and virtualenvwrapper packages
# globally via pip, then create a base virtual environment under
# the branch and install the packages in requirements.txt
#
# todo: get pip / requirements working with the python 3.x
#
# alternate version that does not depend on virtualenvwrapper is
# available here:
# https://gist.github.com/michaelxor/8136225

run_python() {
    if type_exists "brew"; then
        # install latest python 2.x and 3.x branches, if necessary
        if ! formula_exists "python"; then
            e_header "Installing Python 2.x..."
            brew install python

            # make sure we're using brew's python
            brew link --overwrite python
        fi

        if ! formula_exists "python3"; then
            e_header "Installing Python 3.x..."
            brew install python3

            # make sure we're using brew's python3
            brew link --overwrite python3
        fi

        # make sure we're not in a virtualenv already
        if [[ ! -z "$VIRTUAL_ENV" ]]; then
            deactivate
        fi

        # next, we'll install virtualenv and virtualenvwrapper,
        # and create a couple base virtual environments
        if ! pypackage_exists "virtualenv"; then
            e_header "Installing virtualenv..."
            pip install virtualenv
        fi

        if ! pypackage_exists "virtualenvwrapper"; then
            e_header "Installing virtualenvwrapper..."
            pip install virtualenvwrapper
        fi

        # new envs
        INITIAL_ENV="pymordial"
        INITIAL_ENV_3="pymordial3"

        # the first time we run this we'll need to source the
        # included bash startup file
        source config.bash

        # copy some default virtualenvwrapper hooks into the global hook dir
        seek_confirmation "Warning: This step may overwrite your virtualenvwrapper hooks."
        if is_confirmed; then
            ln -fs ${HOME}/.dotfiles/python/virtualenvwrapper/* "${WORKON_HOME}/"
        fi

        # create the 2.x virtualenv
        if [[ ! $(workon | grep -e "^${INITIAL_ENV}$") ]]; then
            e_header "Creating new virtualenv ${INITIAL_ENV}..."
            mkvirtualenv ${INITIAL_ENV}
        fi

        # create the 3.x virtualenv
        if [[ ! $(workon | grep -e "^${INITIAL_ENV_3}$") ]]; then
            e_header "Creating new virtualenv ${INITIAL_ENV_3}..."
            mkvirtualenv --python=python3 ${INITIAL_ENV_3}
        fi

        e_header "Updating pip for all virtual environments..."
        allvirtualenv pip install -U pip

        e_header "Updating packages for ${INITIAL_ENV}..."
        workon ${INITIAL_ENV}
        pip install -r requirements.txt

        # i'm not especially clear on how pip works with python3.x...
        # not seeing any packages come through with pip freeze
        # e_header "Updating packages for ${INITIAL_ENV_3}..."
        # workon ${INITIAL_ENV_3}
        # pip install -r requirements.txt

        deactivate
        [[ $? ]] && e_success "Done"
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi

}

run_python
