#!/usr/bin/env bash
# Exit on any error
set -e
set -u

actionRunnerDir="/home/actions-runner"

cd $actionRunnerDir
# Last step, run it!
./run.sh

# keeps docker running
exec "$@"