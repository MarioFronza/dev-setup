#!/bin/bash

set -e  
export DEBIAN_FRONTEND=noninteractive  


### Install Tmux ###
echo "Installing tmux..."
sudo apt update
sudo apt install -y tmux

# Verify installation
echo "Verifying tmux installation..."
tmux -V
