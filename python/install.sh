#!/usr/bin/env bash
#
# Python
#
# Install pyenv and pyenv-virtualenv tools for management of python
# runtime environments on the machine. Install a number of python
# versions by default, and set the global default to the latest stable
# python version (at this time that is 3.7-dev)

run_python() {
    if type_exists "brew"; then
        e_header "Installing pyenv and recommended dependencies..."
        brew install pyenv \
            pyenv-virtualenv \
            pyenv-which-ext \
            openssl \
            readline \
            sqlite3 \
            xz \
            zlib

        e_header "Installing python 2.7-dev..."
        pyenv install -s 2.7-dev

        e_header "Installing python 3.5-dev..."
        pyenv install -s 3.5-dev

        e_header "Installing python 3.6-dev..."
        pyenv install -s 3.6-dev

        e_header "Installing python 3.7-dev..."
        pyenv install -s 3.7-dev
        pyenv global 3.7-dev

        [[ $? ]] && e_success "Done"
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi

}

run_python
