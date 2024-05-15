return {
  {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require('oil').setup {
      columns = {
        "icon", 
        -- "permissions",
    -- "size",
    -- "mtime",
  },    
    -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),

      -- Open parent directory in floating window
      vim.keymap.set("n", "<space>-", require("oil").toggle_float),
  }
    
  end

  },
}
