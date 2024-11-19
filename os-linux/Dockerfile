ARG VERSION

FROM ubuntu:noble AS builder

COPY build_vm.sh /build_vm.sh
RUN /build_vm.sh

FROM ct-itmo/gh-runner-base:$VERSION

COPY --from=builder /opt /opt

RUN set -eu; \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc; \
    echo 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-18 main' >> /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends build-essential qemu-system-x86 cmake clang-format-18 guestfs-tools linux-headers-6.8.0-45-generic rustc rustfmt linux-lib-rust-6.8.0-45-generic; \
    ln -s /usr/bin/clang-format-18 /usr/bin/clang-format; \
    rm -rf /var/lib/apt/lists/*; \
    echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

USER runner
