#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
IMAGE_TAG=${1:?"Missing IMAGE_TAG"}
RUNNER_ID=${2:?"Missing RUNNER_ID"}

while true; do
    echo "Starting Docker"
    if [[ -f .kill-docker ]]; then
        echo "WARNING!"
        echo "Kill-switch detected, Docker won't be restarted"
    fi

    docker run --rm --name="$RUNNER_ID" \
        --runtime sysbox-runc \
        --env "RUNNER_ID=$RUNNER_ID" \
        --env "RUNNER_LABELS=ubuntu,$IMAGE_TAG" \
        --env-file "$SCRIPT_DIR/.env" \
        "cpp-kt/gh-runner-ubuntu:$IMAGE_TAG"
done
