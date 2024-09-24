FROM nestybox/ubuntu-noble-systemd-docker

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /runner

RUN set -eu; \
    apt-get update; \
    apt-get install -y curl jq sudo unzip wget zip git libicu74 libssl3t64 liblttng-ust1t64; \
    useradd -m runner; \
    usermod -aG docker runner; \
    userdel -r admin; \
    echo "runner ALL= NOPASSWD: /usr/sbin/service docker start" > /etc/sudoers; \
    \
    curl -Ls -o runner.tar.gz https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz; \
    tar xzf ./runner.tar.gz; \
    rm runner.tar.gz; \
    # https://github.com/actions/runner/issues/3391
    # ./bin/installdependencies.sh; \
    \
    curl -Ls -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64; \
    chmod +x /usr/local/bin/dumb-init

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh 

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["startup.sh"]
