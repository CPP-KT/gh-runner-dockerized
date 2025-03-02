ARG CPP_COMPILER
FROM cpp-kt/gh-runner-ubuntu:${CPP_COMPILER}

ARG STACK_RESOLVER

RUN set -eu; \
    sudo apt-get update && sudo apt-get install -y haskell-stack; \
    sudo rm -rf /var/lib/apt/lists/*; \
    stack --resolver $STACK_RESOLVER setup
