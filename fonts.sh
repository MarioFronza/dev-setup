#!/bin/bash

# Exit immediately if a command exits witha non-zero status
set -e

echo "Starting installation of Jetbrains Mono Nerd Font..."

# Define variables
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR="/tmp/jetbrains-mono-font"

# Create temporarily directory for download
mkdir -p "$TEMP_DIR" 

# Download the font
echo "Downloading JetBrains Mono Nerd Font..."
curl -fLo "$TEMP_DIR/JetBrainsMono.zip" "$FONT_URL"

# Create font directory if it does't exist
echo "Creating font directory..."
mkdir -p "$FONT_DIR"

# Extract the font
echo "Extracting font files..."
unzip -o "$TEMP_DIR/JetBrainsMono.zip" -d "$FONT_DIR"

# Refresh font cache
echo "Refreshing font cache..."
fc-cache -fv

# Clean up temporarily files
echo "Cleaning up temporarily files" 
rm -rf "$TEMP_DIR"

echo "JetBrains Mono Nerd Font installed successfully!"
