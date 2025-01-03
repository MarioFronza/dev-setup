#!/bin/bash

set -e

echo -e "\e[94mInstalling Gnome Tweaks...\e[39m"
sudo apt install gnome-tweaks

echo -e "\e[94mInstalling Spotify...\e[39m"
echo -e "\e[94mAdding Spotify's GPG key...\e39m"
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg

echo -e "\e[94mAdding Spotify's repository...\e39m"
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

echo -e "\e[94mUpdating package list and installing Spotify client...\e39m"
sudo apt-get update && sudo apt-get install -y spotify-client

echo -e "\e[94mInstalling Discord...\e[39m"
TEMP_DIR=$(mktemp -d)
DISCORD_DEB="$TEMP_DIR/discord.deb"
wget -O "$DISCORD_DEB" "https://discord.com/api/download?platform=linux&format=deb"

echo -e "\e[94mInstalling Discord...\e[39m"
sudo apt-get update
sudo apt-get install -y "$DISCORD_DEB"

echo -e "\e[94mCleaning up...\e[39m"
rm -rf "$TEMP_DIR"

echo -e "\e[94mInstalling Gear Lever...\e[39m"
flatpak install -y flathub it.mijorus.gearlever

echo -e "\e[94mInstalling VLC...\e[39m"
sudo snap install vlc
