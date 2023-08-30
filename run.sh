#!/usr/bin/env bash
# Exit on any error
set -e

# ${BASH_SOURCE[0]} is the path of the currently executing script.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source shared_vars.sh

# enforce container to restart once the docker daemon is recovered from the 
# shutdown
# Note, running docker in sudo mode had many problems while setting up github workflow
docker run \
    --restart=always \
    -it \
    --network host \
    --name "$container_name" \
    --mount "type=bind,src=$DATASETSRCLOC,dst=$DATASETDSTLOC,readonly" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    "$container_name" \
    /bin/bash -l
