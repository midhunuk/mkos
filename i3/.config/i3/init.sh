#! /bin/sh

sudo pacman -S i3-wm feh xss-lock i3lock

# mkos already cloned and stow should be setup
stow -d ~/mkos -t ~ i3 
