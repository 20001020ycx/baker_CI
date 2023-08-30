#!/bin/bash

# Exit on any error
set -e

# ${BASH_SOURCE[0]} is the path of the currently executing script.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source shared_vars.sh

docker exec -it --user $DOCKER_USER "$container_name" bash