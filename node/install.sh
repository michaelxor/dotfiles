#!/usr/bin/env bash
#
# Node
#
# This installs nvm via git, grabs latest node and sets this as the
# default for new bash sessions.

run_node() {
    e_header "Installing nvm via git..."
    if [[ ! -d "$HOME/.nvm" ]]; then
        git clone https://github.com/nvm-sh/nvm.git "$HOME/.nvm"
    fi

    pushd "$HOME/.nvm"
    git checkout v0.34.0
    source nvm.sh
    popd

    # install latest node
    e_header "Installing latest node..."
    nvm install v12.7.0
    nvm alias default v12.7.0

    # install some helpful packages in default node environment
    e_header "Installing helpful packages into default node environment..."
    nvm run v12.7.0 npm install -g eslint \
        stylelint \
        stylelint-processor-styled-components \
        stylelint-config-styled-components \
        stylelint-config-recommended
}

run_node
