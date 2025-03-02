#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive  

### Install NVM & Node.js ###
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install --lts
fi

### Install SDKMAN & Java ###
if [ ! -d "$HOME/.sdkman" ]; then
    echo "Installing SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk install java
fi

### Install Python ###
sudo apt install -y python3 python3-pip

### Install Go ###
if ! command -v go > /dev/null; then
    echo "Installing Go..."
    GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -oE '^go[0-9]+\.[0-9]+\.[0-9]+')
    GO_TAR="${GO_VERSION}.linux-amd64.tar.gz"
    echo "$GO_TAR"
    curl -OL "https://go.dev/dl/${GO_TAR}"
    sudo tar -C /usr/local -xzf "${GO_TAR}"
    rm "${GO_TAR}"
    echo "export PATH=\$PATH:/usr/local/go/bin" >> "$HOME/.zshrc"
    export PATH=$PATH:/usr/local/go/bin
fi

### Install Rust ###
if ! command -v cargo > /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
    source "$HOME/.cargo/env"
fi

