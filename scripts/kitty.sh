#!/bin/bash
git_repo_location="$HOME/git_repo/mkos"

kitty_config_location="$HOME/.config/kitty"
mkdir -p $kitty_config_location

cd $HOME

kitty_config_repo="$git_repo_location/configs/kitty"
ln -s "$kitty_config_repo/kitty.conf" $kitty_config_location

ln -s "$kitty_config_repo/fzf-launcher.config" $kitty_config_location
