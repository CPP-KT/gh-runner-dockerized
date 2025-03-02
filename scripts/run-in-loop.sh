#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
IMAGE_TAG=${1:?"Missing IMAGE_TAG"}
RUNNER_ID=${2:?"Missing RUNNER_ID"}

DOCKER_IMAGE="cpp-kt/gh-runner-ubuntu:$IMAGE_TAG"
LABELS="$IMAGE_TAG,$(docker inspect --format '{{ index .Config.Labels "gh.labels"}}' "$DOCKER_IMAGE")"

while true; do
    echo "Starting Docker"
    if [[ -f .kill-docker ]]; then
        echo "WARNING!"
        echo "Kill-switch detected, Docker won't be restarted"
    fi

    docker run --rm --name="$RUNNER_ID" \
        --runtime sysbox-runc \
        --env "RUNNER_ID=$RUNNER_ID" \
        --env "RUNNER_LABELS=$LABELS" \
        --env-file "$SCRIPT_DIR/.env" \
        "$DOCKER_IMAGE"
done
