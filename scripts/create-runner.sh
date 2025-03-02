#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

IMAGE_TAG="${1:?"Missing IMAGE_TAG"}"
NAME_PREFIX="${2:-gh-runner-ubuntu}"

RUNNER_ID="${NAME_PREFIX}-${IMAGE_TAG}_$(openssl rand -hex 6)"

run_in_loop() {
    while true; do
        echo "Starting Docker"
        if [[ -f .kill-docker ]]; then
            echo "WARNING!"
            echo "Kill-switch detected, Docker won't be restarted"
        fi

        docker run --rm --name="$NAME" \
            --runtime sysbox-runc \
            --env "RUNNER_ID=$RUNNER_ID" \
            --env "RUNNER_LABELS=ubuntu,$IMAGE_TAG" \
            --env-file "$SCRIPT_DIR/.env" \
            "cpp-kt/gh-runner-ubuntu:$IMAGE_TAG"
    done
}

echo "Starting $RUNNER_ID, use 'screen -r $RUNNER_ID' to attach"

screen -S "$RUNNER_ID" -d -m run_in_loop
