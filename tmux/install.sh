#!/usr/bin/env bash
#
# Tmux
#
# This will install tmux

run_tmux() {
    # verify a valid brew install
    if ! type_exists 'brew'; then
        e_error "Error: Homebrew not found."
        printf "Aborting...\n"
        return
    fi

    e_header "Installing tmux..."
    brew install tmux reattach-to-user-namespace
}

run_tmux
