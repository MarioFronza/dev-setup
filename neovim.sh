#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Download Neovim v0.10.2 tarball
echo "Downloading Neovim v0.10.2..."
curl -L -o nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz

# Extract the tarball
echo "Extracting Neovim tarball..."
tar xzvf nvim-linux64.tar.gz

# Move the extracted files to a proper location
echo "Moving Neovim files to /opt/nvim..."
sudo mv nvim-linux64 /opt/nvim

# Create a symlink for easy access to nvim
echo "Creating symlink for nvim..."
sudo ln -s /opt/nvim/nvim-linux64/bin/nvim /usr/local/bin/nvim
dd

# Verify the installation
echo "Verifying Neovim installation..."
nvim --version

# Clean up the tarball
echo "Cleaning up tarball..."
rm nvim-linux64.tar.gz

echo "Neovim v0.10.2 has been installed successfully!"

