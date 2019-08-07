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

        # i guess some people still write python2 code
        e_header "Installing python 2.7-dev..."
        pyenv install -s 2.7-dev

        e_header "Installing python 3.5-dev..."
        pyenv install -s 3.5-dev

        e_header "Installing python 3.6-dev..."
        pyenv install -s 3.6-dev

        e_header "Installing python 3.7-dev..."
        pyenv install -s 3.7-dev
        pyenv global 3.7-dev

        # install some packages that help vim-python integrations into system python
        # basically i would like these to always be available, even if no more specific
        # version is indicated via a venv or pyenv
        if [[ -x "/usr/local/bin/pip2" ]]; then
            e_header "Installing some helpful py2 packages globally..."
            /usr/local/bin/pip2 install pytest pylint flake8 flake8-bugbear pynvim
        fi
        if [[ -x "/usr/local/bin/pip3" ]]; then
            e_header "Installing some helpful py3 packages globally..."
            /usr/local/bin/pip3 install pytest pylint flake8 flake8-bugbear pynvim
        fi

        [[ $? ]] && e_success "Done"
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi

}

run_python
