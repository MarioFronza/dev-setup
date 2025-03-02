#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive  

echo "Installing Gnome Tweaks..."
if ! command -v gnome-tweaks > /dev/null; then
    sudo apt update
    sudo apt install -y gnome-tweaks
else
    echo "Gnome Tweaks is already installed. Skipping."
fi

echo "Installing Flatpak (if not installed)..."
if ! command -v flatpak > /dev/null; then
    sudo apt install -y flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

echo "Installing Spotify via Flatpak..."
flatpak install -y flathub com.spotify.Client

echo "Installing Discord via Flatpak..."
flatpak install -y flathub com.discordapp.Discord

echo "Installing Gear Lever via Flatpak..."
flatpak install -y flathub it.mijorus.gearlever

echo "Installing VLC..."
if apt-cache show vlc > /dev/null 2>&1; then
    sudo apt install -y vlc
else
    flatpak install -y flathub org.videolan.VLC
fi

echo "All applications installed successfully."
