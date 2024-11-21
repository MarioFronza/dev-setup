#!/bin/bash

set -e

echo -e "\e[94mStarting installation of Jetbrains Mono Nerd Font...\e[39m"

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR="/tmp/jetbrains-mono-font"

mkdir -p "$TEMP_DIR"

echo -e "\e[94mDownloading JetBrains Mono Nerd Font...\e[39m"
curl -fLo "$TEMP_DIR/JetBrainsMono.zip" "$FONT_URL"

echo -e "\e[94mCreating font directory...\e[39m"
mkdir -p "$FONT_DIR"

echo -e "\e[94mExtracting font files...\e[39m"
unzip -o "$TEMP_DIR/JetBrainsMono.zip" -d "$FONT_DIR"

echo -e "\e[94mRefreshing font cache...\e[39m"
fc-cache -fv

echo -e "\e[94mCleaning up temporarily files\e[39m"
rm -rf "$TEMP_DIR"

echo -e "\e[94mJetBrains Mono Nerd Font installed successfully!\e[39m"
