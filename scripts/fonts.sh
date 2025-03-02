#!/bin/bash

set -e  

### Install Fonts ###
FONT_DIR="$HOME/.local/share/fonts"
if ! fc-list | grep -qi "JetBrainsMono"; then
    echo "Installing JetBrains Mono Nerd Font..."
    mkdir -p "$FONT_DIR"
    curl -fLo "$FONT_DIR/JetBrainsMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
    unzip -o "$FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
    rm "$FONT_DIR/JetBrainsMono.zip"
    fc-cache -fv
fi
