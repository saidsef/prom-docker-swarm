#!/usr/bin/env bash

set -e pipefail

export HOST_IP=`ip addr show docker0 | grep inet | awk '{ print $2 }' | head -n 1 | sed -e "s/\/16//"`

if ! [ -x "$(command -v docker)" ]; then
  echo 'Unable to find docker command, please install Docker (https://www.docker.com/) and retry' >&2
  exit 1
fi

echo "Deploying stack"
docker stack deploy -c docker-compose.yml monitoring
