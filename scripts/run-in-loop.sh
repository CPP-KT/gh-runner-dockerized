#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

image_tag=${1:?"Missing image tag"}
runner_id=${2:?"Missing runner id"}

docker_image="cpp-kt/gh-runner-ubuntu:${image_tag}"
labels="${image_tag},$(docker inspect --format '{{ index .Config.Labels "gh.labels"}}' "${docker_image}")"

source "${SCRIPT_DIR}/.env"
memory_limit="${RUNNER_MEMORY_LIMIT}"
cpu_limit="${RUNNER_CPU_LIMIT}"

while true; do
    echo "Starting Docker"
    if [[ -f .kill-docker ]]; then
        echo "WARNING!"
        echo "Kill-switch detected, Docker won't be restarted"
    fi

    docker run --rm --name="${runner_id}" \
        --runtime sysbox-runc \
        --env "RUNNER_ID=${runner_id}" \
        --env "RUNNER_LABELS=${labels}" \
        --env-file "${SCRIPT_DIR}/.env" \
        --memory=${memory_limit} \
        --cpus=${cpu_limit} \
        "${docker_image}"
done
