#!/bin/bash
#
# Ruby
#
# This will install RVM (Ruby enVironment Manager) with the latest
# stable Ruby.  The requirements.txt file defines gems that should
# be installed to the default rvm.

run_ruby() {
    rvm_opts="--ruby --ignore-dotfiles"

    if ! type_exists "rvm"; then
        e_header "Installing latest stable RVM & ruby..."
        curl -sSL https://get.rvm.io | bash -s stable $rvm_opts
    else
        # update RVM & ruby to latest stable
        e_header "Updating to latest stable RVM & ruby..."
        rvm get stable $rvm_opts
    fi

    # we'll need to source these the first time at least
    source path.bash
    source config.bash

    # jump into default environment to install requirements
    rvm use

    local -a gems
    while read p; do
        gems=("${gems[@]}" "$p")
    done < requirements.txt

    if [[ "$gems" ]]; then
        local list_gems=$( printf "%s " "${gems[@]}" )

        e_header "Installing gems..."
        gem install $list_gems
        [[ $? ]] && e_success "Done"
    fi

    # jump back out to system ruby by default
    rvm use system
}

run_ruby
