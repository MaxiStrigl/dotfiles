--plugins that require no or little config

return {
	{ "christoomey/vim-tmux-navigator" }, -- Navigate between tmux and nvim with tmux binds
	{ "tpope/vim-fugitive" },          -- Another Git integration for vim
	{ "tpope/vim-rhubarb" },           -- Github integration for fugitive
	{ "ThePrimeagen/harpoon" },

	{
		-- Hints for keybinds
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		-- Autoclose quotes, parantheses, etc
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Highlight todo, hack, warning, etc in code
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		-- Show indentation
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		setup = function()
			-- vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",

		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

		config = function()
			require("oil").setup()
			vim.keymap.set("n", "-", "<CMD>Oil<CR>")
		end,
	},
}
