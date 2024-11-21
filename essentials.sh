#!/bin/bash

set -e

echo -e "\e[94mUpdating packages...\e[39m"
sudo apt update && sudo apt upgrade -y --allow-downgrades

echo -e "\e[94mInstalling essential packages...\e[39m"
sudo apt install -y \
      git \
      curl \
      wget \
      build-essential \
      xclip \
      vim \
      htop \
      net-tools