ARG VERSION
FROM ct-itmo/gh-runner-base:$VERSION as builder

COPY build_vm.sh /build_vm.sh
RUN /build_vm.sh

FROM ct-itmo/gh-runner-base:$VERSION

COPY --from=builder /opt /opt

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -; \
    echo 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal-17 main' >> /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends build-essential qemu-system-x86 cmake clang-format-17 guestfs-tools linux-headers-6.2.0-31-generic; \
    ln -s /usr/bin/clang-format-17 /usr/bin/clang-format; \
    rm -rf /var/lib/apt/lists/*; \
    echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

USER runner
