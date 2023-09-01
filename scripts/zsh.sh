#!/bin/bash
git_repo_location="$HOME/git_repo/mkos"

cd $HOME

zsh_config_repo="$git_repo_location/configs/zsh"
ln -s "$zsh_config_repo/.zshrc" $HOME
