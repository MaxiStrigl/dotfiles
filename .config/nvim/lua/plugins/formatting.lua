return {
  {
    "nvimtools/none-ls.nvim",

    setup = function()
      local null_ls = require("null-ls")


      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      null_ls.setup({
        border = "rounded",
        sources = {
          --formatting
          --formatting.google_java_format,
          --formatting.prettier,
          formatting.stylua,
          --formatting.ocamlformat,
          -- formatting.clang_format,
        },
        autostart = true,
      })
    end,
  },
}
