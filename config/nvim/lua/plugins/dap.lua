return {
	-- debugging adapter protocol
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			--
			-- adapters
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
			}

			dap.adapters.codelldb = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
			}

			-- configurations
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
			}
			dap.configurations.c = dap.configurations.cpp

			dap.configurations.rust = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						vim.fn.system("cargo build")
						-- return vim.fn.getcwd() .. "/target/debug/" .. "${workspaceFolderBasename}"
						-- choosing the binary directly is useful if you want to debug the test build
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

			vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "De[B]ug [B]reakpoint" })
			vim.keymap.set("n", "<leader>bc", dap.continue, { desc = "De[B]ug [C]ontinue" })
			vim.keymap.set("n", "<leader>bn", dap.step_over, { desc = "De[B]ug [N]ext Line" })
			vim.keymap.set("n", "<leader>bs", dap.step_into, { desc = "De[B]ug [S]tep Into" })
			vim.keymap.set("n", "<leader>bo", dap.step_out, { desc = "De[B]ug Step [O]ut" })
			vim.keymap.set("n", "<leader>bq", dap.terminate, { desc = "De[B]ug [Q]uit" })
			vim.keymap.set("n", "<leader>bh", dap.run_to_cursor, { desc = "De[B]ug until [H]ere" })
		end,
	},

	-- debugging UI
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dapui = require("dapui")
			dapui.setup()

			vim.keymap.set("n", "<leader>bu", dapui.toggle, { desc = "De[B]ug [U]ser Interface" })
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
