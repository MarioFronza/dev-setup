#!/bin/bash

set -e

echo -e "\e[94mConfiguring Git...\e[39m"

git_config_user_email="mariofronza1@gmail.com"

git config --global user.name "MarioFronza"
git config --global user.email "$git_config_user_email"
git config --global init.defaultBranch main

echo -e "\e[94mGenerating an SSH key for Git with ed25519...\e[39m"
echo "y" | ssh-keygen -t ed25519 -C "$git_config_user_email" -f ~/.ssh/id_ed25519 -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo -e "\e[94mCopying SSH key to clipboard...\e[39m"
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
echo "SSH key copied to clipboard. Add it to your GitHub/GitLab account."
