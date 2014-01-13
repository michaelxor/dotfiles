#!/bin/bash

# node path updates
brew_prefix=$(brew --prefix)
if [[ -d "$brew_prefix/share/npm/bin" ]]; then
    path_append "$brew_prefix/share/npm/bin" # Add npm-installed package bin
fi
