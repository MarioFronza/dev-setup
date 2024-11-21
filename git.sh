#!/bin/zsh

echo "Configuring Git..."

git config --global user.name "MarioFronza"
git config --global user.email "mariofronza1@gmai.com"
git config --global init.defaultBranch main

# Generate SSH key for Git using ed25519
echo "Generating an SSH key for Git with ed25519..."
echo "y" | ssh-keygen -t ed25519 -C "$git_config_user_email" -f ~/.ssh/id_ed25519 -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Copying SSH key to clipboard..."
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
echo "SSH key copied to clipboard. Add it to your GitHub/GitLab account."
