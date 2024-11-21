#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install NVM and Node.js
echo "Installing NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export NVM_DIR="$HOME/.nvm"
echo "Installing Node.js (latest LTS) using NVM..."
nvm install --lts

# Install SDKMAN! for Java
echo "Installing SDKMAN! for Java..."
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
echo "Installing latest LTS version..."
sdk install java

# Install Python3
echo "Installing Python3..."
sudo apt install -y python3 python3-pip

# Install Go (Golang)
echo "Installing Go (Golang)..."
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -oE '^go[0-9]+\.[0-9]+\.[0-9]+')
GO_TAR="${GO_VERSION}.linux-amd64.tar.gz"
echo "$GO_TAR"
curl -OL "https://go.dev/dl/${GO_TAR}"
sudo tar -C /usr/local -xzf "${GO_TAR}"
rm "${GO_TAR}"
echo "Adding Go to PATH..."
echo "export PATH=\$PATH:/usr/local/go/bin" >> "$HOME/.zshrc"
export PATH=$PATH:/usr/local/go/bin

# Confirm installation
echo "Installed versions:"
node -v
java -version
python3 --version
go version
