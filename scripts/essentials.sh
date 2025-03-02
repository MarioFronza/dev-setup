#!/bin/bash

set -e  
export DEBIAN_FRONTEND=noninteractive  

echo "Updating system packages..."
sudo apt update && sudo apt full-upgrade -y

echo "Installing essential packages..."
sudo apt install -y --no-install-recommends \
      git \
      curl \
      wget \
      build-essential \
      xclip \
      vim \
      htop \
      iproute2

echo "Essential packages installed successfully."
