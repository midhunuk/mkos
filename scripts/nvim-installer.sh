#!/bin/bash

# Build prerequisites
apt-get install ninja-build gettext cmake unzip curl

# package manager stow for nvim management
apt-get install stow

# building neovim
cd /usr/local/src
git clone https://github.com/neovim/neovim
cd neovim 
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local/stow/neovim" && make install

cd ../../stow
stow neovim

apt-get ripgrep

update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 1 && \
	update-alternatives --set editor /usr/local/bin/nvim
