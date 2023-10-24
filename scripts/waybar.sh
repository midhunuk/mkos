#!/bin/bash
git_repo_location="$HOME/git_repo/mkos"

waybar_config_location="$HOME/.config/waybar"
mkdir -p $waybar_config_location

cd $HOME

waybar_config_repo="$git_repo_location/configs/waybar"
ln -s "$waybar_config_repo/config" $waybar_config_location
ln -s "$waybar_config_repo/style.css" $waybar_config_location

waybar_config_script_location="$waybar_config_location/scripts"

mkdir -p $waybar_config_script_location
ln -s "$waybar_config_repo/scripts/brightness.sh" $waybar_config_script_location


