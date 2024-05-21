return { 
	{ 
	 "catppuccin/nvim", name = "catppuccin",
    dependencies = {
      "folke/tokyonight.nvim",
    },
		lazy = false,
		priority = 1000,
		config = function() 
			vim.cmd.colorscheme "tokyonight-night"
		end
	},
  
}

-----COOL THEMES------
-- catppuccin-mocha
-- tokyonight-storm
-- tokyonight-night
