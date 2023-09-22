#!/bin/bash

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
PARENT_DIR=$(dirname $SCRIPT_DIR)
SELF_DIR=$(basename $SCRIPT_DIR)

CURRENT_VERSION=$(cat $SCRIPT_DIR/runner-version)
NEW_VERSION=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | jq --raw-output '.tag_name' | tr -d v)

if [[ "$NEW_VERSION" != "$CURRENT_VERSION" ]]; then
    echo $NEW_VERSION > $SCRIPT_DIR/runner-version

    docker build -t ct-itmo/gh-runner-base:$NEW_VERSION --build-arg VERSION=$NEW_VERSION $SCRIPT_DIR

    for folder in $(ls $PARENT_DIR); do
        if [[ "$folder" == "$SELF_DIR" || "$folder" =~ ^_ ]]; then
            continue
        fi

        echo "Try $folder"

        docker build -t ct-itmo/gh-runner-$folder:$NEW_VERSION --build-arg VERSION=$NEW_VERSION $PARENT_DIR/$folder
    done
else
    echo "No upgrade needed."
fi
