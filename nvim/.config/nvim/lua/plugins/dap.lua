return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup UI
			dapui.setup()

			-- Auto-open UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Replace with your actual path to CodeLLDB
			local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
			}

			local pickers = require('telescope.pickers')
			local finders = require('telescope.finders')
			local actions = require('telescope.actions')
			local action_state = require('telescope.actions.state')
			local conf = require('telescope.config').values

			-- Telescope binary picker
			local function pick_rust_binary(callback)
				local binaries = vim.fn.glob("target/debug/*", true, true)
				local filtered = vim.tbl_filter(function(path)
					return vim.fn.executable(path) == 1 and not path:match("%.dSYM$")
				end, binaries)

				pickers.new({}, {
					prompt_title = "Select Rust Binary",
					finder = finders.new_table {
						results = filtered,
					},
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							callback(selection[1])
						end)
						return true
					end,
				}):find()
			end

			-- Run cargo build and then pick binary
			local function build_and_pick(callback)
				vim.system({ "cargo", "build" }, { text = true }, function(obj)
					if obj.code == 0 then
						vim.schedule(function()
							pick_rust_binary(callback)
						end)
					else
						vim.notify("Cargo build failed:\n" .. obj.stderr, vim.log.levels.ERROR)
					end
				end)
			end

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return coroutine.create(function(coro)
							build_and_pick(function(path)
								coroutine.resume(coro, path)
							end)
						end)
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
					args = {},
					runInTerminal = false,
				},
			}

			dap.configurations.c = {
				{
					name = "Launch C executable (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						local cwd = vim.fn.getcwd()
						local source = cwd .. "/main.c"
						local binary = cwd .. "a.out"
						local compile_cmd = "gcc -g " .. source .. " -o " .. binary
						local compile_result = os.execute(compile_cmd)
						if compile_result ~= 0 then
							error("Compile error.")
						end
						return binary
					end,
					cwd = "${workspaceFolder}",
					-- stopOnEntry = true,
					args = {},
					runInTerminal = false,
					showDisassembly = "never",
				},
			}

			-- Signs & Keybindings
			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })

			vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Dap Continue" })
			vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Dap Step Over" })
			vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Dap Step Into" })
			vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Dap Step Out" })
			vim.keymap.set("n", "<F9>", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set Conditional Breakpoint" })
		end,
	},
}
