#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

image_tag="${1:?"Missing image tag"}"
name_prefix="${2:-gh-runner-ubuntu}"

runner_id="${name_prefix}-${image_tag}_$(openssl rand -hex 6)"

echo "Starting ${runner_id}, use 'screen -r ${runner_id}' to attach"

screen -S "${runner_id}" -dm "${SCRIPT_DIR}/run-in-loop.sh" "${image_tag}" "${runner_id}"
