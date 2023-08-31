#!/bin/bash
git_repo_location="$HOME/git_repo/mkos"

nvim_config_location="$HOME/.config/nvim"
mkdir -p $nvim_config_location

cd $HOME

nvim_config_repo="$git_repo_location/configs/nvim"
ln -s "$nvim_config_repo/init.lua" $nvim_config_location

nvim_config_lua="$nvim_config_location/lua"
mkdir -p $nvim_config_lua
ln -s "$nvim_config_repo/lua/packer_init.lua" $nvim_config_lua

nvim_config_core="$nvim_config_lua/core"
mkdir -p $nvim_config_core
ln -s "$nvim_config_repo/lua/core/colors.lua" $nvim_config_core
ln -s "$nvim_config_repo/lua/core/keymaps.lua" $nvim_config_core
ln -s "$nvim_config_repo/lua/core/options.lua" $nvim_config_core

nvim_config_plugin="$nvim_config_location/after/plugin"
mkdir -p $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/dap.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/fugitive.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/indent_blankline.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/lsp.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/lualine.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/neovim_tree.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/telescope.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/treesitter.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/trouble.lua" $nvim_config_plugin
ln -s "$nvim_config_repo/after/plugin/undotree.lua" $nvim_config_plugin
