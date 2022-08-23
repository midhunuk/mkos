-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use 'wbthomason/packer.nvim'
  -- plugins

  -- Color schemes
  use 'navarasu/onedark.nvim'

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }

  use 'hrsh7th/nvim-cmp'           -- The completion plugin the main plugin
  use 'hrsh7th/cmp-buffer'         -- source for buffer completions
  use 'hrsh7th/cmp-path'           -- source for file path completions
  use 'hrsh7th/cmp-cmdline'        -- source for cmdline completions
  use 'saadparwaiz1/cmp_luasnip'   -- source for snippet completions
  use 'hrsh7th/cmp-nvim-lsp'       -- source for lsp complections 
  use 'f3fora/cmp-spell'           -- source for vim spell check 
  use 'hrsh7th/cmp-nvim-lua'
  use 'rafamadriz/friendly-snippets'

  use 'L3MON4D3/LuaSnip' --snippet engine - It is required by nvim-cmp and lsp

  use 'VonHeikemen/lsp-zero.nvim' -- enable LSP
  use 'neovim/nvim-lspconfig' -- enable LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'nvim-treesitter/nvim-treesitter' -- for syntax highlighting 


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
