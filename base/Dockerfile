FROM nestybox/ubuntu-jammy-systemd-docker

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /runner

RUN apt-get update; \
    apt-get install -y curl jq sudo unzip wget zip git; \
    useradd -m runner; \
    usermod -aG docker runner; \
    userdel -r admin; \
    echo "runner ALL= NOPASSWD: /usr/sbin/service docker start" > /etc/sudoers; \
    \
    curl -Ls -o runner.tar.gz https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz; \
    tar xzf ./runner.tar.gz; \
    rm runner.tar.gz; \
    ./bin/installdependencies.sh; \
    \
    curl -Ls -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64; \
    chmod +x /usr/local/bin/dumb-init

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh 

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["startup.sh"]
