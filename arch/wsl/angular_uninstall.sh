#!/bin/bash

echo "Uninstalling Angular CLI..."
sudo npm uninstall -g @angular/cli

echo "Uninstalling npm and Node.js..."
sudo pacman -Rns --noconfirm nodejs npm

echo "Cleaning up unnecessary dependencies..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm

echo "System cleanup..."
sudo pacman -Scc --noconfirm

echo "Uninstallation complete."
