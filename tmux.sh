#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install tmux
echo "Installing tmux..."
sudo apt update
sudo apt install -y tmux

# Verify installation
echo "Verifying tmux installation..."
tmux -V
