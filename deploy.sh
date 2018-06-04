#!/usr/bin/env bash

set -e pipefail

export HOST_IP=`ip addr show docker0 | grep inet | awk '{ print $2 }' | head -n 1 | sed -e "s/\/16//"`

if ! [ -x "$(command -v docker)" ]; then
  echo 'Unable to find docker command, please install Docker (https://www.docker.com/) and retry' >&2
  exit 1
fi

echo "Downloading docker-compose"
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o ./docker-compose
chmod +x docker-compose

echo "Building Containers"
./docker-compose build

echo "Deploying stack"
docker stack deploy -c docker-compose.yml monitoring
