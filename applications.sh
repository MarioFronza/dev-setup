#!/bin/bash

# Update system packages
echo "Updating packages..."
sudo apt update && sudo apt upgrade -y
  
# Install essential packages
echo "Installing essential packages..."
sudo apt install -y git curl wget build-essential xclip

# Install Zsh
echo "Installing Zsh..."
sudo apt install -y zsh

# Install additional packages as needed
echo "Installing additional packages..."
sudo apt install -y vim htop net-tools
