#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define the repository URL
DOTFILES_REPO="https://github.com/MarioFronza/dotfiles.git"
DOTFILES_DIR="$HOME/Workspaces/github/dotfiles" 

# Create the target directory if it doesn't exist
echo "Creating the directory for dotfiles..."
mkdir -p "$HOME/Workspaces/github"

# Clone the dotfiles repository
echo "Cloning the dotfiles repository..."
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

# Navigate to the repository directory
echo "Navigating to the dotfiles directory..."
cd "$DOTFILES_DIR"

# Run the bootstrap script to install the dotfiles
echo "Running the bootstrap script to install dotfiles..."
./install/bootstrap.sh

# Confirm completion
echo "Dotfiles setup completed successfully!"

