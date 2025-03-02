#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive  

### Install Alacritty ###
echo "Updating the system and installing dependencies..."
sudo apt update
sudo apt install -y \
    cmake \
    g++ \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    python3

# Clone the Alacritty repository
echo "Cloning the Alacritty repository..."
git clone https://github.com/alacritty/alacritty.git
cd alacritty

# Build Alacritty
echo "Building Alacritty..."
cargo build --release

# Install Alacritty
echo "Installing Alacritty..."
sudo cp target/release/alacritty /usr/local/bin

# Set up desktop entry
echo "Setting up desktop entry..."
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Verify installation
echo "Verifying Alacritty installation..."
alacritty --version

# Cleanup
echo "Cleaning up temporary Alacritty repository..."
cd ..
rm -rf alacritty

# Clone Alacritty theme repository
THEME_REPO="https://github.com/alacritty/alacritty-theme"
THEME_DIR="$HOME/.config/alacritty/themes"

mkdir -p "$THEME_DIR"

echo "Cloning Alacritty theme repository..."
git clone "$THEME_REPO" "$THEME_DIR"

echo "Theme cloned successfully into $THEME_DIR"
echo "Alacritty has been installed successfully."
