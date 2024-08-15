ARG UBUNTU_VERSION=20.04
ARG LLVM_VERSION=12

FROM ubuntu:$UBUNTU_VERSION

ARG LLVM_VERSION

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -q update \
    && apt-get install -y --no-install-recommends ca-certificates software-properties-common curl gnupg2 \
    && curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - \
    && apt-add-repository "deb http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-$LLVM_VERSION main" \
    && apt-get -q update \
    && apt-get install -y --no-install-recommends sudo git ssh zlib1g-dev libzstd-dev automake autoconf cmake make lldb ninja-build gcc g++ gfortran build-essential libtool llvm-$LLVM_VERSION-dev clang-format clangd clang-$LLVM_VERSION libclang-$LLVM_VERSION-dev libomp-$LLVM_VERSION-dev libblas-dev libeigen3-dev libboost-dev python3 python3-pip \
    if [[ "$UBUNTU_VERSION" == "24.04" ]] ; then python3 -m pip install --break-system-packages lit pathlib2 ; python3 -m pip install lit pathlib2 ; fi \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && apt-get autoremove -y --purge \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $USERNAME /commandhistory \
    && echo $SNIPPET >> "/home/$USERNAME/.bashrc"

RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
        /home/$USERNAME/.vscode-server-insiders/extensions \
    && chown -R $USERNAME \
        /home/$USERNAME/.vscode-server \
        /home/$USERNAME/.vscode-server-insiders
        
RUN mkdir -p /workspaces/Enzyme/build \
    && chown -R $USERNAME /workspaces/Enzyme/build

ENV DEBIAN_FRONTEND=

USER $USERNAME
