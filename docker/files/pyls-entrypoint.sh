#!/usr/bin/env bash

set -ex

if [ ! -d ${VENV_PATH}/bin ]; then
    /tmp/python-pip.sh ${VENV_PATH} /tmp/pyls-pip.txt
fi

source ${VENV_PATH}/bin/activate
pyls --tcp --port ${LSP_PORT} --check-parent-process -v
deactivate
