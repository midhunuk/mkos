#!/bin/bash
git_repo_location="$HOME/git_repo/mkos"

sway_config_location="$HOME/.config/sway"
mkdir -p $sway_config_location

cd $HOME

sway_config_repo="$git_repo_location/configs/sway"
ln -s "$sway_config_repo/config" $sway_config_location

sway_config_d_location="$HOME/.config/sway/config.d"
mkdir -p $sway_config_d_location

sway_config_d_repo="$git_repo_location/configs/sway/config.d"
ln -s "$sway_config_d_repo/workspaces" $sway_config_d_location

sway_config_d_repo="$git_repo_location/configs/sway/config.d"
ln -s "$sway_config_d_repo/statusbar" $sway_config_d_location


