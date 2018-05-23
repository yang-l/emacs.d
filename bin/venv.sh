#!/usr/bin/env bash

set -e

# $1 - virtualenv path
# $2 - pip packages

if [ -d "$1" ]; then
    if [ ! -L "$1" ]; then
        virtualenv -p $(which python3) "$1"
        source "${1}"/bin/activate
        python3 -m pip install -U pip
        python3 -m pip install -U -r ${2:-$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/requirements.txt}
    fi
fi
