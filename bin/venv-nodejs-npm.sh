#!/usr/bin/env bash

set -e

# $1 - virtualenv path
# $2 - pip packages
# $3 - npm packages

if [ -d "${1}" ]; then
    if [ ! -L "${1}" ]; then
        virtualenv -p $(which python) "${1}"
        source "${1}"/bin/activate
        python -m pip install -U pip
        python -m pip install -U -r "${2}"

        ## Node.js configure
        nodeenv -p
        # /Applications/Python\ 3.6/Install\ Certificates.command
        npm i -g "${3}"

        deactivate
    fi
fi
