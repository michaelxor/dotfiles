#!/bin/bash
#
# Node.js
#
# This installs Node.js via Homebrew and a list of common
# dependencies using npm.
#
# Add packages to requirements.txt as necessary. This
# installs packages globally, so this list should remain
# small and include only packages you plan to run via the
# command line

run_node() {
    # If npm is missing, try an install via brew
    if ! type_exists 'npm'; then
        if type_exists 'brew'; then
            # install node (npm is packaged with node) if necessary
            if ! noout formula_exists "node"; then
                e_header "Installing Node.js..."
                brew install node
            fi
        fi
    fi

    if type_exists 'npm'; then
        e_header "Installing Node.js packages..."

        # Check desired homebrew formulae & install missing
        e_header "Reading desired packages from ${PWD##*/}/requirements.txt..."
        local  packages
        while read p; do
            packages="$packages $p"
        done < ${PWD}/requirements.txt

        # Install packages globally and quietly
        npm install $packages --global --quiet

        [[ $? ]] && e_success "Done"
    else
        printf "\n"
        e_error "Error: npm not found."
        printf "Aborting...\n"
        exit
    fi

}

source ../lib/utils

run_node
