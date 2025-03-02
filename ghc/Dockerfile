ARG CPP_COMPILER
FROM cpp-kt/gh-runner-ubuntu:${CPP_COMPILER}

ARG STACK_RESOLVER

RUN set -eu; \
    apt-get update && apt-get install -y haskell-stack; \
    rm -rf /var/lib/apt/lists/*; \
    stack --resolver $STACK_RESOLVER setup
