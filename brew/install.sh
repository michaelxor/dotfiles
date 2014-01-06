#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

run_brew() {
    # verify a valid brew install
    if type_exists 'brew'; then
        # Use the latest version of Homebrew
        e_header "Updating Homebrew..."
        brew update
        [[ $? ]] && e_success "Done"

        # Upgrade any already-installed formulae
        e_header "Updating any existing Homebrew formulae..."
        brew upgrade
        [[ $? ]] && e_success "Done"

        # this will give us access to newer versions of rsync, grep, etc
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

        brew cleanup
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi
}

# install homebrew
if ! type_exists 'brew'; then
    e_header "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

run_brew
