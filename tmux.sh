#!/bin/bash

set -e

echo -e "\e[94mInstalling tmux...\e[39m"
sudo apt update
sudo apt install -y tmux

echo -e "\e[94mVerifying tmux installation...\e[39m"
tmux -V
