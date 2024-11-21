#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install Docker and Docker Compose
echo "Installing Docker..."
sudo apt install ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker --version
sudo docker compose version

# Add the current user to the Docker group to run Docker commands without sudo
echo "Adding user to Docker group..."
sudo groupadd docker
sudo usermod -aG docker $USER

echo "Docker and Docker Compose have been installed and configured."
