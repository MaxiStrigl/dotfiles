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
}
