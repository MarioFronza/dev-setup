#!/bin/bash
set -e  
export DEBIAN_FRONTEND=noninteractive  

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Setting up development tools..."

# Function to run each installation script
install_script() {
    local script_name="$SCRIPT_DIR/$1.sh"
    if [ -f "$script_name" ]; then
        chmod +x "$script_name"
        echo "Running $1 installation..."
        "$script_name"
    else
        echo "Warning: $1 script not found. Skipping..."
    fi
}

# Call all dev tool installation scripts
install_script "git"
install_script "zsh"
install_script "fonts"
install_script "langs"
install_script "docker"
install_script "alacritty"
install_script "editors"
install_script "tmux"
install_script "dotfiles"

### Final Setup ###
echo "Installed versions:"
node -v || echo "Node.js not found"
java -version || echo "Java not found"
python3 --version || echo "Python not found"
go version || echo "Go not found"
cargo --version || echo "Rust not found"
docker --version || echo "Docker not found"
nvim --version || echo "Neovim not found"
tmux -V || echo "Tmux not found"

echo "Development tools setup completed successfully!"
