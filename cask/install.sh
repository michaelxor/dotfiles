#!/bin/bash
#
# Homebrew Cask
#
# This installs some of the apps we'd like from Cask

run_cask() {
    # verify a valid brew install
    if type_exists 'brew'; then
        # install homebrew cask if necessary
        if ! noout formula_exists "brew-cask"; then
            e_header "Installing Homebrew Cask..."
            brew tap phinze/homebrew-cask
            brew install brew-cask
        fi

        # check desired cask applications & install missing
        e_header "Reading desired packages from ${PWD##*/}/requirements.txt..."
        local -a missing_apps
        while read p; do
            if ! app_exists "$p"; then
                missing_apps=("${missing_apps[@]}" "$p")
            fi
        done < requirements.txt

        if [[ "$missing_apps" ]]; then
            # Convert the array of missing apps into a list of space-separate strings
            local list_apps=$( printf "%s " "${missing_apps[@]}" )

            # Install all missing apps
            e_header "Installing missing Cask applications..."
            brew cask install $list_apps
            [[ $? ]] && e_success "Done"
        fi

        # make cask installed apps visible to alfred, if alfred is installed
        if noout app_exists 'alfred'; then
            brew cask alfred link 2> /dev/null
        fi
    else
        printf "\n"
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        exit
    fi
}

run_cask
