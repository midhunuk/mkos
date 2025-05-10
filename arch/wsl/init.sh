#!/bin/bash

# Usage: sudo ./arch-wsl-setup.sh <username> <email>

set -e

USERNAME="$1"
EMAIL="$2"

if [[ -z "$USERNAME" || -z "$EMAIL" ]]; then
    echo "Usage: $0 <username> <email>"
    exit 1
fi

echo "[*] Updating system..."
pacman -Syu --noconfirm

echo "[*] Creating user: $USERNAME"
useradd -m "$USERNAME"
passwd "$USERNAME"

echo "[*] Installing essentials: sudo, vi, git, openssh, wget, unzip, stow, zsh, bat"
pacman -S --noconfirm sudo vi git openssh wget unzip stow zsh bat

echo "[*] Configuring sudo for wheel group..."
EDITOR=vi visudo

echo "[*] Adding $USERNAME to wheel group"
usermod -aG wheel "$USERNAME"

echo "[*] Switching to user: $USERNAME"
su - "$USERNAME" <<EOSU

echo "[*] Generating SSH key for git"
ssh-keygen -t ed25519 -C "$EMAIL" -f ~/.ssh/id_ed25519 -N ""

eval "\$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "[*] Generating SSH key for git"
ssh-keygen -t ed25519 -C "$EMAIL" -f ~/.ssh/id_ed25519 -N ""

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo ""
echo "======================================="
echo "🗝️  SSH Public Key (add this to GitHub):"
echo "======================================="
cat ~/.ssh/id_ed25519.pub
echo "======================================="
echo ""
read -p "Press enter after adding the SSH key to GitHub to continue..."

echo "[*] Cloning mkos dotfiles repo"
git clone git@github.com:midhunuk/mkos.git ~/mkos

echo "[*] Installing oh-my-zsh"
sh -c "\$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

echo "[*] Stowing zsh config"
cd ~
stow -d ~/mkos -t ~ zsh

echo "[*] Installing JetBrainsMono Nerd Font"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv

EOSU

echo "[*] Setup complete!"
