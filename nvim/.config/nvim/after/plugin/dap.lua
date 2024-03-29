local dap, dapui = require("dap"), require("dapui")
require('dap.ext.vscode').load_launchjs()

-- launch UI on events
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set("n", "<Leader>de", dapui.close)

dapui.setup()

--#region rust

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = '/home/mk/.local/share/nvim/mason/bin/codelldb',
		args = { "--port", "${port}" },
	}
}

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}

--#endregion

-- Key Mapping
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<S-F11>", dap.step_out)
vim.keymap.set('n', '<F6>', [[:lua require"osv".launch({port = 8086})<CR>]])
