#!/bin/bash

#DOCKER_BUILDKIT=0
#COMPOSE_DOCKER_CLI_BUILD=0
ARQUITETURA=$([ $(uname -m) == 'arm64' ] && echo 'linux/arm64/v8' || echo 'linux/amd64' ]);

docker build --progress=plain --no-cache --platform $ARQUITETURA --tag dft-wildfly .
# docker build --progress=plain --no-cache --tag dft-wildfly .