#!/bin/bash

set -e

echo -e "\e[94mInstalling Zsh...\e[39m"
sudo apt install -y zsh

echo -e "\e[94mInstalling Oh My Zsh...\e[39m"
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\e[94mSetting Zsh as the default shell...\e[39m"
chsh -s $(which zsh)

echo ""
echo -e "\e[94mInstalling Powerlevel10k theme...\e[39m"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

echo -e "\e[94mInstalling recommended plugins...\e[39m"
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"

git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_DIR/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting $PLUGINS_DIR/zsh-syntax-highlighting

echo -e "\e[94mUpdating .zshrc to include plugins...\e[39m"

echo -e "\e[94mApplying changes...\e[39m"
source $HOME/.zshrc

echo -e "\e[94mZsh setup is complete! Restart your terminal to use Zsh.\e[39m"
