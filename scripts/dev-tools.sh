#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive  

echo "Updating system packages..."
sudo apt update && sudo apt install -y --no-install-recommends \
    git curl wget unzip tar ca-certificates gnupg build-essential xclip vim htop iproute2

### Git Configuration ###
echo "Configuring Git..."
git config --global user.name "MarioFronza"
git config --global user.email "mariofronza1@gmail.com"
git config --global init.defaultBranch main

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "mariofronza1@gmail.com" -f "$HOME/.ssh/id_ed25519" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_ed25519"
fi

### Install Fonts ###
FONT_DIR="$HOME/.local/share/fonts"
if ! fc-list | grep -qi "JetBrainsMono"; then
    echo "Installing JetBrains Mono Nerd Font..."
    mkdir -p "$FONT_DIR"
    curl -fLo "$FONT_DIR/JetBrainsMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
    unzip -o "$FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
    rm "$FONT_DIR/JetBrainsMono.zip"
    fc-cache -fv
fi

### Install Zsh & Oh My Zsh ###
if ! command -v zsh > /dev/null; then
    echo "Installing Zsh..."
    sudo apt install -y zsh
    chsh -s "$(which zsh)"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

### Install Zsh Plugins ###
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
[ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
[ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"

### Install Powerlevel10k ###
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

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

### Install Docker ###
if ! command -v docker > /dev/null; then
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "$USER"
    newgrp docker
fi

### Install Alacritty ###
if ! command -v alacritty > /dev/null; then
    echo "Installing Alacritty..."
    sudo apt install -y alacritty
fi

### Install Neovim ###
if ! command -v nvim > /dev/null; then
    echo "Installing Neovim..."
    sudo apt install -y neovim
fi

### Install Tmux ###
if ! command -v tmux > /dev/null; then
    echo "Installing Tmux..."
    sudo apt install -y tmux
fi

### Install Dotfiles ###
DOTFILES_REPO="https://github.com/MarioFronza/dotfiles.git"
DOTFILES_DIR="$HOME/Workspaces/github/dotfiles"
mkdir -p "$HOME/Workspaces/github"

if [ -d "$DOTFILES_DIR" ]; then
    echo "Updating dotfiles..."
    git -C "$DOTFILES_DIR" pull
else
    echo "Cloning dotfiles..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

bash "$DOTFILES_DIR/install/bootstrap.sh"

### Final Setup ###
echo "Installed versions:"
node -v
java -version
python3 --version
go version
cargo --version
docker --version
nvim --version
tmux -V

echo "System setup completed successfully!"
