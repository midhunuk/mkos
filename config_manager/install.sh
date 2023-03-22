#!/usr/bin/env bash
# DO not move or copy file to other location relative file path used 
cargo clean
cargo build --release

sudo rm -rf /usr/local/bin/config_manager
sudo cp target/release/config_manager /usr/local/bin/config_manager

rm -rf ~/.config/config_manager/
[ -d ~/.config/config_manager/ ] || mkdir ~/.config/config_manager/
cp ../apps/config_manager/config.yml ~/.config/config_manager/config.yml
