return {
	-- general
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},

		opts = {
			handlers = {},
			ensure_installed = {
				"codelldb",
				"debugpy",
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "[D]ebug [B]reakpoint" })
			vim.keymap.set("n", "<leader>dr", "<cmd> DapNew <CR>", { desc = "[D]ebug [R]un" })
			vim.keymap.set("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "[D]ebug [C]ontinue" })
			vim.keymap.set("n", "<leader>do", "<cmd> DapStepOver <CR>", { desc = "[D]ebug step [o]ver" })
			vim.keymap.set("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "[D]ebug step [I]nto" })
			vim.keymap.set("n", "<leader>dO", "<cmd> DapStepOut <CR>", { desc = "[D]ebug [S]tep [O]ut" })
			vim.keymap.set("n", "<leader>dx", "<cmd> DapTerminate <CR>", { desc = "[D]ebug terminate" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				-- dapui.close()
			end
		end,
	},
	--- python
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},

		config = function()
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)

			vim.keymap.set("n", "<leader>dr", "<cmd> DapNew <CR>", { desc = "[D]ebug [R]un" })
			vim.keymap.set("n", "<leader>dt", function()
				require("dap-python").test_method()
			end, { desc = "[D]ebug run [T]ests" })
		end,
	},
}
