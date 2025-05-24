#!/usr/bin/env bash

echo "installing apps"
sudo pacman -S alacritty zsh git neovim stow bat tree xclip python python-pip git-delta meld

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


stow -d ~/mkos -t ~ alacritty
