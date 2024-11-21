#!/bin/zsh

echo "Running init.sh to execute all setup scripts..."

# Call applications.sh
echo "Calling applications.sh"
./applications.sh || { echo "Failed to execute applications.sh"; exit 1; }

# Call git.sh
echo "Calling git.sh..."
./git.sh || { echo "Failed to execute git.sh"; exit 1; }

# Call zsh.sh
echo "Calling zsh.sh..."
./zsh.sh || { echo "Failed to execute zsh.sh"; exit 1; }

# Call langs.sh
echo "Calling langs.sh"
./langs.sh || { echo "Failed to execute langs.sh"; exit 1; }

# Call docker.sh
./docker.sh || { echo "Failed to execute docker.sh"; exit 1; }

echo "All setup scripts executed successfully!"
