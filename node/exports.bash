#!/bin/bash

# these are sometimes referenced in other tools that
# launch Chrome (ex. Karma for node)
if [[ -d "/opt/homebrew-cask/Caskroom/google-chrome" ]]; then
    export CHROME_BIN="/opt/homebrew-cask/Caskroom/google-chrome/stable-channel/Google Chrome.app/Contents/MacOS/Google Chrome"
elif [[ -d "/Applications/Google Chrome.app" ]]; then
    export CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
fi

if [[ -d "/opt/homebrew-cask/Caskroom/google-chrome-canary" ]]; then
    export CHROME_CANARY_BIN="/opt/homebrew-cask/Caskroom/google-chrome-canary/latest/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
elif [[ -d "/Applications/Google Chrome Canary.app" ]]; then
    export CHROME_CANARY_BIN="/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
fi
