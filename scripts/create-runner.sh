#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

IMAGE_TAG="${1:?"Missing IMAGE_TAG"}"
NAME_PREFIX="${2:-gh-runner-ubuntu}"

RUNNER_ID="${NAME_PREFIX}-${IMAGE_TAG}_$(openssl rand -hex 6)"

echo "Starting $RUNNER_ID, use 'screen -r $RUNNER_ID' to attach"

screen -S "$RUNNER_ID" -dm "$SCRIPT_DIR/run-in-loop.sh" "$IMAGE_TAG" "$RUNNER_ID"
