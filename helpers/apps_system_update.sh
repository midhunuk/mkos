cd ~
cd ~/git_repo/mkos/apps/apps_list/fedora
dnf list installed > apps

git add apps
git commit -m "system_update"

