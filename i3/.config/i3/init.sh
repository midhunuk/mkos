#! /bin/sh

sudo pacman -S i3-wm feh i3lock polybar

yay -S xidlehook betterlockscreen
# mkos already cloned and stow should be setup
stow -d ~/mkos -t ~ i3 
stow -d ~/mkos -t ~ polybar
