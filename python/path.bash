#!/bin/bash

# prepend virtualenv bin if a virtualenv is active
# figure out why workon doesn't do this by default...
if [[ ! -z $VIRTUAL_ENV ]]; then
    PATH="$VIRTUAL_ENV/bin:$PATH"
fi
