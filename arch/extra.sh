#!/usr/bin/env bash

#yay cura
#!/bin/bash

# List of packages to install
packages=(
  obsidian
  freecad
  calibre
  wget
  htop
  ripgrep
  bat
  vlc
  tmux
)

for pkg in "${packages[@]}"; do
  if pacman -Qi "$pkg" &> /dev/null; then
    echo "$pkg is already installed, skipping."
  else
    echo "$pkg is not installed. Installing..."
    sudo pacman -S "$pkg"
  fi
done

# List of AUR and official packages to install via yay
aurpackages=(
	cura-bin
)

for pkg in "${aurpackages[@]}"; do
  if yay -Qi "$pkg" &> /dev/null; then
    echo "$pkg is already installed, skipping."
  else
    echo "$pkg is not installed. Installing..."
    yay -S "$pkg"
  fi
done
