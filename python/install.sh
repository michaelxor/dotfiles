#!/bin/bash
#
# Python
#
# This will install the latest python 2.x branch via
# Homebrew, install virtualenv and pew packages
# globally via pip, then create a base virtual environment under
# the branch and install the packages in requirements.txt
#
# todo: get pip / requirements working with the python 3.x
#
# alternate version that does not depend on pew is
# available here:
# https://gist.github.com/michaelxor/8136225

run_python() {
    if type_exists "brew"; then
        # install latest python 2.x and 3.x branches, if necessary
        if ! formula_exists "python@2"; then
            e_header "Installing Python 2.x..."
            brew install python@2

            # make sure we're using brew's python
            brew link --overwrite python@2
        fi

        if ! formula_exists "python"; then
            e_header "Installing Python 3.x..."
            brew install python

            # make sure we're using brew's python3
            brew link --overwrite python
        fi

        # make sure we're not in a virtualenv already
        if [[ ! -z "$VIRTUAL_ENV" ]]; then
            e_error "Error: Cannot continue inside of a virtual environment.  Please deactivate your virtualenv before and try agian."
            return
        fi

        # next, we'll install pew and create a couple base virtual environments
        e_header "Installing pew..."
        pip install pew

        # new envs
        INITIAL_ENV="pymordial"
        INITIAL_ENV_3="pymordial3"

        # load up any functions
        declare -a functions=(
            $HOME/.dotfiles/python/functions/*
        )
        for index in ${!functions[*]}
        do
            source ${functions[$index]}
        done

        # the first time we run this we'll need to source the
        # included bash startup file
        source config.bash

        # create the 2.x virtualenv
        if [[ ! $(pew workon | tr ' ' '\n' | grep -e "^${INITIAL_ENV}$") ]]; then
            e_header "Creating new virtualenv ${INITIAL_ENV}..."
            pew new ${INITIAL_ENV} -d
        fi

        # create the 3.x virtualenv
        if [[ ! $(pew workon | tr ' ' '\n' | grep -e "^${INITIAL_ENV_3}$") ]]; then
            e_header "Creating new virtualenv ${INITIAL_ENV_3}..."
            pew new --python=python3 ${INITIAL_ENV_3} -d
        fi

        e_header "Updating pip for all virtual environments..."
        pew inall pip install -U pip

        e_header "Updating packages for ${INITIAL_ENV}..."
        pew in ${INITIAL_ENV} pip install -r requirements.txt

        # i'm not especially clear on how pip works with python3.x...
        # not seeing any packages come through with pip freeze
        # e_header "Updating packages for ${INITIAL_ENV_3}..."
        # pew in ${INITIAL_ENV_3} pip install -r requirements.txt

        [[ $? ]] && e_success "Done"
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi

}

run_python
