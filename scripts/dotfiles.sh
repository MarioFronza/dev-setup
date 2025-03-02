#!/bin/bash
set -e

### Install Dotfiles ###
# Define variables
DOTFILES_REPO="https://github.com/MarioFronza/dotfiles.git"
DOTFILES_DIR="$HOME/Workspaces/github/dotfiles" 

# Create directory for dotfiles
echo "Creating the directory for dotfiles..."
mkdir -p "$HOME/Workspaces/github"

# Clone the dotfiles repository
echo "Cloning the dotfiles repository..."
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

# Navigate to the dotfiles directory
echo "Navigating to the dotfiles directory..."
cd "$DOTFILES_DIR"

# Run the bootstrap script to install dotfiles
echo "Running the bootstrap script to install dotfiles..."
./install/bootstrap.sh

echo "Dotfiles setup completed successfully!"
