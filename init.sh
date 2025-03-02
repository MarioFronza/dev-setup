#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive  

SCRIPT_DIR="$(cd "$(dirname "$0")/scripts" && pwd)"

echo "Debian setup script!"
echo "Select which components you want to install:"
echo "1) Essential packages"
echo "2) Development tools (Docker, Git, Node.js, Go, Rust, etc.)"
echo "3) Apps (Spotify, Discord, VLC, Gear Lever)"
echo "4) Install everything"

read -p "Enter numbers separated by spaces (e.g., 1 3 5): " choices

install_script() {
    local script_name="$SCRIPT_DIR/$1.sh"
    if [ -f "$script_name" ]; then
        chmod +x "$script_name"
        echo "Running $1..."
        "$script_name"
    else
        echo "Warning: $1 script not found. Skipping..."
    fi
}

for choice in $choices; do
    case $choice in
        1) install_script "essentials" ;;
        2) install_script "dev-tools" ;;
        3) install_script "apps" ;;
        4)
            install_script "essentials"
            install_script "dev-tools"
            install_script "apps"
            ;;
        *) echo "Invalid option: $choice" ;;
    esac
done

echo "Installation complete!"
