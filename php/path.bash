#!/bin/bash

# calling php-version prepends the given version to our $PATH
if [[ -r $(brew --prefix php-version)/php-version.sh ]]; then
    source $(brew --prefix php-version)/php-version.sh && php-version 5
fi
