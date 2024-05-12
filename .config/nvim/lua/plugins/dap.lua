return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",

		config = function()
			local dap = require("dap")
			dap.adapters.codelldb = {
				type = "server",
				host = "127.0.0.1",
				port = 13000, -- 💀 Use the port printed out or specified with `--port`
			}

			-- C C++ Rust
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "/home/maxi/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						vim.fn.system("make TARGET=program")
						return vim.fn.getcwd() .. "/program"
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},

		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
		end,
	},
}
