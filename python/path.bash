#!/bin/bash

# prepend virtualenv bin if a virtualenv is active
# figure out why workon doesn't do this by default...
if [[ ! -z $VIRTUAL_ENV ]]; then
    path_prepend "$VIRTUAL_ENV/bin"
fi
