#!/bin/bash

set -e

echo -e "\e[94mUpdating the system and installing dependencies...\e[39m"
sudo apt update
sudo apt install -y \
    cmake \
    g++ \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    python3

echo -e "\e[94mCloning the Alacritty repository...\e[39m"
git clone https://github.com/alacritty/alacritty.git
cd alacritty

echo -e "\e[94mBuilding Alacritty...\e[39m"
cargo build --release

echo -e "\e[94mInstalling Alacritty...\e[39m"
sudo cp target/release/alacritty /usr/local/bin

echo -e "\e[94mSetting up desktop entry...\e[39m"
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

echo -e "\e[94mVerifying Alacritty installation...\e[39m"
alacritty --version

echo -e "\e[94mCleaning up temporary Alacritty repository...\e[39m"
cd ..
rm -rf alacritty

THEME_REPO="https://github.com/alacritty/alacritty-theme"
THEME_DIR="$HOME/.config/alacritty/themes"

mkdir -p $THEME_DIR

echo -e "\e[94mCloning Alacritty theme repository...\e[39m"
git clone $THEME_REPO $THEME_DIR

echo -e "\e[94mTheme cloned successfully into $THEME_DIR\e[39m"

echo -e "\e[94mAlacritty has been installed successfully.\e[39m"
