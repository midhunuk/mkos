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
			require('nvim-autopairs').setup {}
		end
	}

	-- telescope
	use { 'nvim-telescope/telescope.nvim' }

	-- for async lua function
	-- required for telescope
	use 'nvim-lua/plenary.nvim'

	-- undo tree
	use 'mbbill/undotree'

	-- git plugin
	use 'tpope/vim-fugitive'

	-- file explorer
	use { 'nvim-tree/nvim-tree.lua' }

	-- devicons
	-- required for nvim-tree
	use 'nvim-tree/nvim-web-devicons'

	-- group comment
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	--  Diagonstic Window
	use 'folke/trouble.nvim'

	-- Status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- for styling indents
	use "lukas-reineke/indent-blankline.nvim"

	-- rust setup
	use 'williamboman/mason.nvim'    
    use 'williamboman/mason-lspconfig.nvim'

	use 'neovim/nvim-lspconfig'
	use 'simrat39/rust-tools.nvim'

	-- Completion framework:
    use 'hrsh7th/nvim-cmp' 

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'                             
    use 'hrsh7th/cmp-path'                              
    use 'hrsh7th/cmp-buffer'                            
    use 'hrsh7th/vim-vsnip'  

	-- treesitter
	use 'nvim-treesitter/nvim-treesitter'

	-- Debugging
	-- use 'nvim-lua/plenary.nvim' already used 
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
