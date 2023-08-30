#!/bin/bash

# Exit on any error
set -e

# ${BASH_SOURCE[0]} is the path of the currently executing script.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source shared_vars.sh

# --build-arg: allows you to pass a build-time variable that could be used in 
# Dockerfile, for example, we can specify ARG DOCKER_USER in Dockerfile
# -t: allows you to name the image
docker build \
    --build-arg DOCKER_USER="$DOCKER_USER" \
    --build-arg HOST_OS="$HOST_OS" \
    --build-arg TOKEN="$TOKEN" \
    --build-arg GITHUBREPO="$GITHUBREPO" \
    --build-arg RUNNERNAME="$RUNNERNAME" \
    -t "$container_name" \
    "$script_dir" \
    --file "$script_dir"/Dockerfile
