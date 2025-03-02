#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive  

### Install Neovim ###
# Neovim version
NVIM_VERSION="0.10.2"
NVIM_TARBALL="nvim-linux64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim/releases/download/v$NVIM_VERSION/$NVIM_TARBALL"
NVIM_INSTALL_DIR="/opt/nvim"
NVIM_BIN="/usr/local/bin/nvim"

# Check if Neovim is already installed
if command -v nvim > /dev/null; then
    echo "Neovim is already installed. Skipping installation."
    exit 0
fi

# Download Neovim
echo "Downloading Neovim v$NVIM_VERSION..."
curl -L -o "$NVIM_TARBALL" "$NVIM_URL"

# Extract Neovim
echo "Extracting Neovim tarball..."
tar xzvf "$NVIM_TARBALL"

# Move Neovim files
echo "Moving Neovim files to $NVIM_INSTALL_DIR..."
sudo mv nvim-linux64 "$NVIM_INSTALL_DIR"

# Create symlink
echo "Creating symlink for nvim..."
sudo ln -sf "$NVIM_INSTALL_DIR/nvim-linux64/bin/nvim" "$NVIM_BIN"

# Verify installation
echo "Verifying Neovim installation..."
nvim --version

# Cleanup
echo "Cleaning up tarball..."
rm -f "$NVIM_TARBALL"

echo "Neovim v$NVIM_VERSION has been installed successfully."

### Install Toolbox
# Define directories
TMP_DIR=$(mktemp -d)
INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
SYMLINK_DIR="$HOME/.local/bin"

# Ensure temporary files are removed on exit
trap 'rm -rf "$TMP_DIR"' EXIT

# Fetch the latest JetBrains Toolbox download URL
echo "Fetching the URL of the latest JetBrains Toolbox version..."
ARCHIVE_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' \
  | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}' | sed 's/[", ]//g')
ARCHIVE_FILENAME=$(basename "$ARCHIVE_URL")

# Download the JetBrains Toolbox archive
echo "Downloading $ARCHIVE_FILENAME..."
wget -q --show-progress -cO "$TMP_DIR/$ARCHIVE_FILENAME" "$ARCHIVE_URL"

# Extract the archive
echo "Extracting to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
rm -f "$INSTALL_DIR/jetbrains-toolbox"
tar -xzf "$TMP_DIR/$ARCHIVE_FILENAME" -C "$INSTALL_DIR" --strip-components=1
chmod +x "$INSTALL_DIR/jetbrains-toolbox"

# Create a symlink for easy access
echo "Creating symlink at $SYMLINK_DIR/jetbrains-toolbox..."
mkdir -p "$SYMLINK_DIR"
rm -f "$SYMLINK_DIR/jetbrains-toolbox"
ln -s "$INSTALL_DIR/jetbrains-toolbox" "$SYMLINK_DIR/jetbrains-toolbox"

# Run the application (unless running in CI)
if [ -z "$CI" ]; then
  echo "Running JetBrains Toolbox for the first time..."
  ( "$INSTALL_DIR/jetbrains-toolbox" & )
  echo -e "\nInstallation complete! JetBrains Toolbox should now be running and accessible in your application list."
  echo "You can also run it from the terminal using 'jetbrains-toolbox' (ensure that $SYMLINK_DIR is in your PATH)."
else
  echo -e "\nInstallation complete! Running in CI mode -- skipped launching the application."
fi
