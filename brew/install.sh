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

        if formula_exists 'bash'; then
            local brew_bash_path="$(brew --prefix)/bin/bash"
            if [[ "$SHELL" != "$brew_bash_path" ]]; then
                seek_confirmation "Your current shell is not Homebrew installed bash, would you like to update your default shell?"

                if is_confirmed; then
                    local brew_bash=$(cat /etc/shells | grep "$brew_bash_path")
                    if ! [[ $brew_bash ]]; then
                        e_header "Did not find Homebrew bash in allowable shells, adding..."
                        sudo bash -c "echo '$brew_bash_path' >> /etc/shells"
                    fi

                    e_header "Updating default shell to Homebrew bash, this will only take effect for new shells"
                    chsh -s $brew_bash_path
                fi
            fi
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
