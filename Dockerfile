ARG UBUNTU_VERSION=20.04

FROM ubuntu:$UBUNTU_VERSION

ARG LLVM_VERSION=12

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update \
    && apt-get install -y ca-certificates software-properties-common curl gnupg2 \
    && curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - \
    && apt-add-repository "deb http://apt.llvm.org/`lsb_release -c | cut -f2`/ llvm-toolchain-`lsb_release -c | cut -f2`-$LLVM_VERSION main" || true \
    && apt-get update \
    && apt-get install -y autoconf cmake gcc g++ libtool gfortran llvm-$LLVM_VERSION-dev clang-$LLVM_VERSION libomp-$LLVM_VERSION-dev libeigen3-dev libboost-dev python3 python3-pip \
    && python3 -m pip install --upgrade pip setuptools \
    && python3 -m pip install lit \
    && touch /usr/lib/llvm-$LLVM_VERSION/bin/yaml-bench \
    && rm -r /var/lib/apt/lists/*