return {
  "nvim-treesitter/nvim-treesitter",

  config = function()
    require("nvim-treesitter.configs").setup({
    ensure_installed = { 
      "bash", 
      "lua", 
      "java", 
      "rust", 
      "html", 
      "css", 
      "javascript", 
      "typescript", 
      "json", 
      "markdown", 
      "ocaml",
      "cpp",
      "c_sharp",
      "python",
      "c",
    },
    sync_install = false,
    auto_install = true,

    highlight = {
      enable = true,
    },

    indent = {
      enable = true,
    },
  })
  end,
}

