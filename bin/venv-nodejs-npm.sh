#!/usr/bin/env bash

set -ex

# $1 - virtualenv path
# $2 - python version
# $3 - pip packages file
# $4 - node.js version
# $5 - npm packages - comma separated package string

if [ -d "${1}" ]; then
    if [ ! -L "${1}" ]; then
        virtualenv -p $(which ${2}) "${1}"
        source "${1}"/bin/activate
        ${2} -m pip install -U pip
        ${2} -m pip install -U -r "${3}"

        ## Node.js configure
        nodeenv -p --node=${4}
        # /Applications/Python\ 3.6/Install\ Certificates.command
        for APP in $(echo ${5} | sed 's/,/ /g')
        do
            npm i -g "${APP}"
        done

        deactivate
    fi
fi
