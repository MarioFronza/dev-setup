#!/bin/zsh

set -e

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Zsh as the default shell
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Install Powerlevel10k theme
echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
sed -i 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' $HOME/.zshrc

# Install recommended plugins
echo "Installing recommended plugins..."
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_DIR/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting $PLUGINS_DIR/zsh-syntax-highlighting

# Update .zshrc to include plugins
echo "Updating .zshrc to include plugins..."
sed -i 's|plugins=(.*)|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|' $HOME/.zshrc

# Apply changes
echo "Applying changes..."
source $HOME/.zshrc

echo "Zsh setup is complete! Restart your terminal to use Zsh."
