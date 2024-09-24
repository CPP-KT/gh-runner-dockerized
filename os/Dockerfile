ARG VERSION
FROM ct-itmo/gh-runner-base:$VERSION

RUN set -eu; \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc; \
    echo 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-18 main' >> /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu python3 clang-format-18; \
    ln -s /usr/bin/clang-format-18 /usr/bin/clang-format; \
    rm -rf /var/lib/apt/lists/*

USER runner
