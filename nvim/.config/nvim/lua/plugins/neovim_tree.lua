return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	config = function()
		-- Disable netrw to prevent conflicts
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Setup nvim-tree
		require("nvim-tree").setup({
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
		})

		-- Key mappings
		vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeFocus, { desc = "Focus File Explorer" })
		vim.keymap.set("n", "<leader>ce", vim.cmd.NvimTreeToggle, { desc = "Toggle File Explorer" })
	end,
}
