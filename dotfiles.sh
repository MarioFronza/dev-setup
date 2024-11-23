#!/bin/bash

set -e

DOTFILES_REPO="https://github.com/MarioFronza/dotfiles.git"
DOTFILES_DIR="$HOME/Workspaces/github/dotfiles" 

echo -e "\e[94mCreating the directory for dotfiles...\e[39m"
mkdir -p "$HOME/Workspaces/github"

echo -e "\e[94mCloning the dotfiles repository...\e[39m"
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

echo -e "\e[94mNavigating to the dotfiles directory...\e[39m"
cd "$DOTFILES_DIR"

echo -e "\e[94mRunning the bootstrap script to install dotfiles...\e[39m"
./install/bootstrap.sh

echo -e "\e[94mDotfiles setup completed successfully!\e[39m"

