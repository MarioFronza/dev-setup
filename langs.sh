#!/bin/bash

set -e

echo -e "\e[94mInstalling NVM (Node Version Manager)...\e[39m"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export NVM_DIR="$HOME/.nvm"
echo -e "\e[94mInstalling Node.js (latest LTS) using NVM...\e[39m"
nvm install --lts

echo -e "\e[94mInstalling SDKMAN! for Java...\e[39m"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
echo -e "\e[94mInstalling latest LTS version...\e[39m"
sdk install java

echo -e "\e[94mInstalling Python3...\e[39m"
sudo apt install -y python3 python3-pip

echo -e "\e[94mInstalling Go (Golang)...\e[39m"
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -oE '^go[0-9]+\.[0-9]+\.[0-9]+')
GO_TAR="${GO_VERSION}.linux-amd64.tar.gz"
echo "$GO_TAR"
curl -OL "https://go.dev/dl/${GO_TAR}"
sudo tar -C /usr/local -xzf "${GO_TAR}"
rm "${GO_TAR}"
echo -e "\e[94mAdding Go to PATH...\e[39m"
echo "export PATH=\$PATH:/usr/local/go/bin" >> "$HOME/.zshrc"
export PATH=$PATH:/usr/local/go/bin

echo -e "\e[94mInstalling Rust...\e[39m"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
source $HOME/.cargo/env

echo -e "\e[94mInstalled versions:\e[39m"
node -v
java -version
python3 --version
go version
cargo --version
