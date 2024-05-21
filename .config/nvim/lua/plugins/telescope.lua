return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("telescope").setup({
      file_ignore_patterns = {
        "node_modules",
        ".git",
        ".next",
      },
      hidden = true,
    })
  end,
}
