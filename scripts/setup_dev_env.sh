#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install required packages
echo "Installing kitty, zsh, stow, and curl..."
sudo apt install -y kitty zsh stow curl

# Set kitty as the default terminal emulator
echo "Setting kitty as the default terminal emulator..."
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty

# Set zsh as the default shell
echo "Setting zsh as the default shell..."
chsh -s $(which zsh)

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Backup and delete existing .zshrc
echo "Backing up and deleting existing .zshrc..."
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
echo "Stowing the configuration from the cloned repository..."
stow -d ~/mkos -t ~ zsh

# Backup and remove existing kitty configuration
echo "Backing up and removing existing kitty configuration if it exists..."
[ -d ~/.config/kitty ] && mv ~/.config/kitty ~/.config/kitty.bak
echo "Stowing the kitty configuration from the cloned repository..."
stow -d ~/mkos -t ~ kitty

# Final message
echo "Setup complete. Please restart your terminal or VM for changes to take effect."
