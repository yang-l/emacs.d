#!/usr/bin/env bash

set -ex

# $1 - virtualenv path
# $2 - python version
# $3 - pip packages

if [ -d "${1}" ]; then
    if [ ! -L "${1}" ]; then
        virtualenv -p $(which ${2}) "${1}"
        source "${1}"/bin/activate
        ${2} -m pip install -U pip
        ${2} -m pip install -U -r "${3}"
        deactivate
    fi
fi
