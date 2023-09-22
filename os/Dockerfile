ARG VERSION
FROM ct-itmo/gh-runner-base:$VERSION

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -; \
    echo 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal-17 main' >> /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu python3 clang-format-17; \
    ln -s /usr/bin/clang-format-17 /usr/bin/clang-format; \
    rm -rf /var/lib/apt/lists/*

USER runner
