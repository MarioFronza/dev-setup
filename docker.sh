#!/bin/bash

set -e

echo -e "\e[94mInstalling Docker...\e[39m"
sudo apt install ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo -e "\e[94mVerifying Docker installation...\e[39m"

sudo docker --version
sudo docker compose version

echo -e "\e[94mAdding user to Docker group...\e[39m"
sudo groupadd docker
sudo usermod -aG docker $USER

echo -e "\e[94mDocker and Docker Compose have been installed and configured.\e[39m"
