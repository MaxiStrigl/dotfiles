return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    dependencies = {
      "folke/tokyonight.nvim",
    },
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },

}

-----COOL THEMES------
-- catppuccin-mocha
-- tokyonight-storm
-- tokyonight-night
