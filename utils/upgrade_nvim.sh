#!/usr/bin/env bash
set -e
export DEBIAN_FRONTEND=noninteractive

### Upgrade Neovim ###
NVIM_VERSION="0.11.2"
NVIM_TARBALL="nvim-linux-x86_64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim/releases/download/v$NVIM_VERSION/$NVIM_TARBALL"
NVIM_INSTALL_DIR="/opt/nvim"
NVIM_BIN="/usr/local/bin/nvim"

# Clean previous install
echo "Removing old Neovim files..."
sudo rm -rf "$NVIM_INSTALL_DIR/nvim-linux-x86_64"

# Download Neovim
echo "Downloading Neovim v$NVIM_VERSION..."
curl -L -o "$NVIM_TARBALL" "$NVIM_URL"

# Extract Neovim
echo "Extracting Neovim tarball..."
tar xzf "$NVIM_TARBALL"
rm "$NVIM_TARBALL"

# Move Neovim files
echo "Moving Neovim files to $NVIM_INSTALL_DIR..."
sudo mkdir -p "$NVIM_INSTALL_DIR"
sudo mv nvim-linux-x86_64 "$NVIM_INSTALL_DIR/"

# Create symlink
echo "Creating symlink for nvim..."
sudo ln -sf "$NVIM_INSTALL_DIR/nvim-linux-x86_64/bin/nvim" "$NVIM_BIN"

echo "Neovim v$NVIM_VERSION installed successfully."
