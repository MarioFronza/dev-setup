#!/bin/bash

set -e

echo -e "\e[94mDownloading Neovim v0.10.2...\e39m"
curl -L -o nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz

echo -e "\e[94mExtracting Neovim tarball...\e39m"
tar xzvf nvim-linux64.tar.gz

echo -e "\e[94mMoving Neovim files to /opt/nvim...\e39m"
sudo mv nvim-linux64 /opt/nvim

echo -e "\e[94mCreating symlink for nvim...\e39m"
sudo ln -s /opt/nvim/nvim-linux64/bin/nvim /usr/local/bin/nvim

echo -e "\e[94mVerifying Neovim installation...\e39m"
nvim --version

echo -e "\e[94mCleaning up tarball...\e39m"
rm nvim-linux64.tar.gz

echo -e "\e[94mNeovim v0.10.2 has been installed successfully!\e39m"

