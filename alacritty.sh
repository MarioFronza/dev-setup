#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update the system and install dependencies
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

# Build Alacritty using Cargo
echo "Building Alacritty..."
cargo build --release

# Install the Alacritty binary
echo "Installing Alacritty..."
sudo cp target/release/alacritty /usr/local/bin

# Install Alacritty's desktop entry (optional for launcher)
echo "Setting up desktop entry..."
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Check if Alacritty was installed successfully
echo "Verifying Alacritty installation..."
alacritty --version

# Cleanup the temporary Alacritty folder
echo "Cleaning up temporary Alacritty repository..."
cd ..
rm -rf alacritty

# Theme
# Set the theme repository URL
THEME_REPO="https://github.com/alacritty/alacritty-theme"
THEME_DIR="$HOME/.config/alacritty/themes"

# Create the themes directory if it doesn't exist
mkdir -p $THEME_DIR

# Clone the theme repository into the themes directory
echo "Cloning Alacritty theme repository..."
git clone $THEME_REPO $THEME_DIR

# Confirm completion
echo "Theme cloned successfully into $THEME_DIR"


echo "Alacritty has been installed successfully."
