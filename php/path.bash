#!/bin/bash

# calling php-version prepends the given version to our $PATH
if $(brew list php-version >/dev/null 2>&1); then
    if [[ -r $(brew --prefix php-version)/php-version.sh ]]; then
        source $(brew --prefix php-version)/php-version.sh && php-version 5
    fi
fi
