ARG VERSION
ARG COMPILER

FROM ct-itmo/gh-runner-base:$VERSION

RUN docker pull ghcr.io/cpp-kt/ubuntu:gcc-14; \
    docker pull ghcr.io/cpp-kt/ubuntu:clang-19; \
    echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

USER runner
