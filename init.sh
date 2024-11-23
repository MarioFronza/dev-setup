#!/bin/bash

set -e

echo -e "\e[94mRunning init.sh to execute all setup scripts...\e[39m"

echo -e "\e[94mCalling essentials.sh\e[39m"
./essentials.sh

echo -e "\e[94mCalling git.sh...\e[39m"
./git.sh

echo -e "\e[94mCalling zsh.sh...\e[39m"
./zsh.sh

echo -e "\e[94mCalling fonts.sh...\e[39m"
./fonts.sh

echo -e "\e[94mCalling langs.sh\e[39m"
./langs.sh

echo -e "\e[94mCalling docker.sh\e[39m"
./docker.sh

echo -e "\e[94mCalling alacritty.sh\e[39m"
./alacritty

echo -e "\e[94mCalling neovim.sh\e[39m"
./neovim

echo -e "\e[94mCalling toolbox.sh\e[39m"
./toolbox

echo -e "\e[94mCalling tmux.sh\e[39m"
./tmux

echo -e "\e[94mCalling dotfiles.sh\e[39m"
./dotfiles

echo -e "\e[94mCalling apps.sh\e[39m"
./apps

echo -e "\e[94mAll setup scripts executed successfully!\e[39m"
