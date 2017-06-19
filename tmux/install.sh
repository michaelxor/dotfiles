#!/usr/bin/env bash
#
# Tmux
#
# This will install some basic tmuxinator

run_tmux() {
    # verify a valid brew install
    if ! type_exists 'brew'; then
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        return
    fi

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

    if ! type_exists "gem"; then
        e_error "Error: gem not found."
        printf "Aborting..."
        return
    fi

    if ! gem_exists "tmuxinator"; then
        sudo gem install tmuxinator
    fi

    if ! type_exists "tmuxinator"; then
        e_error "Installation of tmuxinator failed, unable to continue."
        printf "Aborting..."
        return
    fi

    # local install_path=$(gem which tmuxinator)
    # source "${install_path%/*}/../completion/tmuxinator.bash"
}

run_tmux
