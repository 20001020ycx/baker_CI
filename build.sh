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
    --build-arg DOCKER_USER="baker_CI" \
    --build-arg HOST_OS="linux" \
    --build-arg TOKEN="AONIWJHSYQE4ABCL77ETGA3E57LDC" \
    -t "$container_name" \
    "$script_dir" \
    --file "$script_dir"/Dockerfile
