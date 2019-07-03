.PHONY: python-lsp

python-lsp: python-lsp.dockerfile
		mkdir -p ~/${VENV_DIR}/python
		docker build --build-arg UNAME=${USER}      \
					--build-arg UID=$(shell id -u)  \
					--build-arg GID=$(shell id -g)  \
					--compress                      \
					-f python-lsp.dockerfile        \
					-t emacs/python-pyls-lsp:latest \
		.
