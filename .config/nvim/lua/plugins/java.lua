return {
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      local config = {
        cmd = {'java' },
        root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
      }
      require("jdtls").start_or_attach(config);
    end,
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    config = function()
      require("java").setup()

      local keybinds = require("user.keybinds").lsp_keybinds

      local on_attach = function(_client, buffer_number)
        keybinds(buffer_number)
      end

      require("lspconfig").jdtls.setup({
        settings = {
          java = {
            format = {
              enabled = false,
            },
          },
        },
        on_attach = on_attach,
      })

      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.google_java_format
        },
        autostart = true,
      })
    end,
  },
}
