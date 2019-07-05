#!/usr/bin/env bash

set -ex

# $1 - virtualenv path
# $2 - pip packages
# $3 - node.js version
# $4 - npm packages - comma separated package string

if [ -d "${1}" ]; then
    if [ ! -L "${1}" ]; then
        virtualenv -p $(which python) "${1}"
        source "${1}"/bin/activate
        python -m pip install -U pip
        python -m pip install -U -r "${2}"

        ## Node.js configure
        nodeenv -p --node=${3}
        # /Applications/Python\ 3.6/Install\ Certificates.command
        for APP in $(echo ${4} | sed 's/,/ /g')
        do
            npm i -g "${APP}"
        done

        deactivate
    fi
fi
