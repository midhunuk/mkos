#!/bin/bash

# Detect the operating system and install Git accordingly
echo "Detecting operating system..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        echo "Debian/Ubuntu-based system detected. Installing Git..."
        sudo apt update && sudo apt install -y git
    elif command -v pacman &> /dev/null; then
        echo "Arch-based system detected. Installing Git..."
        sudo pacman -Syu --noconfirm git
    elif command -v dnf &> /dev/null; then
        echo "Fedora-based system detected. Installing Git..."
        sudo dnf install -y git
    else
        echo "Unsupported Linux distribution."
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macOS detected. Installing Git..."
    brew install git
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

# Configure Git with SSH securely
echo "Configuring Git with SSH..."
read -p "Enter your email address for the SSH key: " email
echo "Generating SSH key..."
ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
echo "Adding SSH key to the ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo "Copy the following SSH key to your Git provider:"
cat ~/.ssh/id_ed25519.pub
read -p "Press Enter after you have added the SSH key to your Git provider..."

# Test SSH connectivity to GitHub
echo "Testing SSH connectivity to GitHub..."
ssh -T git@github.com || { echo "Error: Unable to connect to GitHub via SSH. Please ensure your SSH key is added to your Git provider."; exit 1; }

echo "Git configuration complete. You can now use Git with SSH securely."
