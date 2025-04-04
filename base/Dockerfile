ARG CPP_COMPILER
FROM ghcr.io/cpp-kt/ubuntu:${CPP_COMPILER}

ARG RUNNER_VERSION

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /runner

RUN set -eu; \
    apt-get update; \
    apt-get install -y curl jq sudo unzip wget zip git nasm libicu74 libssl3t64 liblttng-ust1t64; \
    rm -rf /var/lib/apt/lists/*; \
    curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh; \
    useradd -m runner && usermod -aG docker runner; \
    curl -Ls -o runner.tar.gz \
        https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz; \
    tar xzf ./runner.tar.gz; \
    rm runner.tar.gz; \
    curl -Ls -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64; \
    chmod +x /usr/local/bin/dumb-init; \
    echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

ARG CPP_COMPILER
LABEL gh.labels="ubuntu,${CPP_COMPILER},base"

USER runner

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["startup.sh"]
