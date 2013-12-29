#!/bin/bash
#
# Python
#
# This will install Python 2.x and 3.x

run_python() {

    # Check for Python
    if type_exists 'python'; then
        mkdir -p $HOME/virtualenvs

        # Name your first "bootstrap" environment:
        INITIAL_ENV=$HOME/virtualenvs/pymordial

        # Force remove the pymordial directory if it's already there.
        if [ -e "${INITIAL_ENV}" ]; then
            printf "pymordial virtualenv already exists, skipping..."
            return
        fi

        # Options for your first environment:
        ENV_OPTS=''

        # Set to whatever python interpreter you want for your first environment:
        PYTHON=$(type -P python)

        # Latest virtualenv from pypa
        URL_BASE=https://github.com/pypa/virtualenv/tarball/master

        # Name on local fs
        TAR_NAME=virtualenv-tmp.tar.gz

        e_header "Installing new python virtual environment to $INITIAL_ENV"

        # --- Real work starts here ---
        curl -Lo $TAR_NAME $URL_BASE
        tar xzf $TAR_NAME

        # Discover the name of the untarred directory
        UNTARRED_NAME=$(tar tzf $TAR_NAME | sed -e 's,/.*,,' | uniq)

        # Create the first "bootstrap" environment & install virtualenv
        $PYTHON $UNTARRED_NAME/virtualenv.py $ENV_OPTS $INITIAL_ENV
        $INITIAL_ENV/bin/pip install $TAR_NAME

        # Don't need these anymore.
        rm -rf $UNTARRED_NAME
        rm -f $TAR_NAME
    else
        print "\n"
        e_error "Error: python not found."
        printf "Aborting...\n"
        exit
    fi

}
