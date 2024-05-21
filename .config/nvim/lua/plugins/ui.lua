return {
  {
    --UI for selecting when debugging
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end,
  },
  { --Notifications bottom right
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup {}
    end,
  },
}
