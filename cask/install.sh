#!/bin/bash
#
# Homebrew Cask
#
# This installs some of the apps we'd like from Cask

run_cask() {
    # verify a valid brew install
    if type_exists 'brew'; then
        # this will give us access to beta versions, like Sublime Text 3
        e_header "Tapping any new repos..."
        while read p; do
            brew tap "$p" 2> /dev/null
        done < taps.txt

        # check desired cask applications & install missing
        # e_header "Reading desired packages from ${PWD##*/}/requirements.txt..."
        e_header "Installing or Updating Cask applications..."
        local -a apps
        while read p; do
            apps=("${apps[@]}" "$p")
            brew cask install $p
        done < requirements.txt

        if [[ "$apps" ]]; then
            # Convert the array of missing apps into a list of space-separate strings
            local list_apps=$( printf "%s " "${apps[@]}" )

            # dumb way to guess if quicklook restart is necessary
            if [[ $list_apps =~ "ql" || $list_apps =~ "quicklook" ]]; then
                qlmanage -r
            fi

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
