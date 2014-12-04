#!/bin/bash
#
# PHP
#
# This will install php-version for simple php version switching. You'll
# also get the packages listed in requirements.txt

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
            e_header "Installing missing Homebrew formulae..."
            for formula in ${missing_formulae[@]}; do
                brew install $formula
                [[ $? ]] && e_success "Done"
                brew link --overwrite $formula
            done
        fi
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi
}

run_php
