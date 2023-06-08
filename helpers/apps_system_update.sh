#!/bin/bash
cd ~
cd ~/git_repo/mkos/apps/apps_list/fedora
dnf list installed > apps

read -p "Enter commit message: " commit_message
if [[ -z "$commit_message" ]]; then
	commit_message="System update"
fi

git add apps
git commit -m "$commit_message"

