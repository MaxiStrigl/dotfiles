return{
  {
		"hrsh7th/nvim-cmp",

		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim", --symbols in auto completion
    },
    config = function() 
      require("completion")
    end,
		},
}
