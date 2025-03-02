#!/usr/bin/env bash
set -eu

echo "Starting supervisor (Docker)"
sudo service docker start

auth_url="https://api.github.com/orgs/${GITHUB_OWNER}/actions/runners/registration-token"
registration_url="https://github.com/${GITHUB_OWNER}"

generate_token() {
  local payload
  local runner_token

  payload=$(curl -sX POST -H "Authorization: token ${GITHUB_PERSONAL_TOKEN}" "${auth_url}")
  runner_token=$(echo "${payload}" | jq .token --raw-output)

  if [ "${runner_token}" == "null" ]; then
    echo "${payload}"
    exit 1
  fi

  echo "${runner_token}"
}

remove_runner() {
  ./config.sh remove --token "$(generate_token)"
}

service docker status
echo "Registering runner ${RUNNER_ID}"

RUNNER_TOKEN=$(generate_token)
test $? -ne 0 && {
  echo "Debugging token"
  echo "${RUNNER_TOKEN}"
  exit 1
}

./config.sh \
  --name "${RUNNER_ID}" \
  --labels "${RUNNER_LABELS}" \
  --token "${RUNNER_TOKEN}" \
  --url "${registration_url}" \
  --unattended \
  --replace \
  --ephemeral \
  --disableupdate

trap 'remove_runner; exit 130' SIGINT
trap 'remove_runner; exit 143' SIGTERM

./run.sh "$*"
