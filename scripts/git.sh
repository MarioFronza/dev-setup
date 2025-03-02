#!/bin/bash

set -e  

### Git Configuration ###
echo "Configuring Git..."
git config --global user.name "MarioFronza"
git config --global user.email "mariofronza1@gmail.com"
git config --global init.defaultBranch main

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "mariofronza1@gmail.com" -f "$HOME/.ssh/id_ed25519" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_ed25519"
fi

