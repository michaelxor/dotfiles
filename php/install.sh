#!/bin/bash
#
# PHP
#
# This will install php-version for simple php version switching. You'll
# also get the latest PHP 5.4.x and PHP 5.5.x branches.

run_php() {
    # verify a valid brew install
    if type_exists 'brew'; then
        e_header "Tapping any new repos..."
        while read p; do
            brew tap "$p" 2> /dev/null
        done < taps.txt

        # Check desired homebrew formulae & install missing
        e_header "Reading desired packages from ${PWD##*/}/requirements.txt..."
        local -a missing_formulae
        while read p; do
            if ! formula_exists $p; then
                missing_formulae=("${missing_formulae[@]}" "$p")
            fi
        done < requirements.txt

        if [[ "$missing_formulae" ]]; then
            # Convert the array of missing formulae into a list of space-separate strings
            local list_formulae=$( printf "%s " "${missing_formulae[@]}" )

            # install the missinge formulae
            e_header "Installing missing Homebrew formulae..."
            brew install $list_formulae
            [[ $? ]] && e_success "Done"
        fi
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi
}

run_php
