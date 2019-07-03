FROM python:3.7-stretch

RUN set -ex                                  && \
    apt-get update                           && \
    DEBIAN_FRONTEND=noninteractive              \
    apt-get install -y                          \
                    --no-install-recommends     \
                    virtualenv               && \
    apt-get --purge autoremove               && \
    apt-get clean                            && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# non-root user creation (& mirror to the current login user on the host)
ARG UNAME=docker
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -l -m -u $UID -g $GID -o -s /bin/bash $UNAME

USER $UNAME
WORKDIR /home/$UNAME

COPY files/pyls-pip.txt /tmp
COPY files/python-pip.sh /tmp

ENV VENV_PATH="virtualenv/python"
ENV LSP_PORT="60010"

VOLUME /home/$UNAME/$VENV_PATH
EXPOSE $LSP_PORT/tcp

COPY files/pyls-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
