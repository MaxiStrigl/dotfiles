return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost" },

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "nvimtools/none-ls.nvim",
  },

  config = function()
    local null_ls = require("null-ls")
    local keybinds = require("user.keybinds").lsp_keybinds

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "tsserver",
        "html",
        "bashls",
        "cssls",
        "jsonls",
        "marksman",
        "rust_analyzer",
        "volar",
      },
    })

    local servers = {
      bashls = {},
      clangd = {},
      lua_ls = {},
      tsserver = {},
      html = {},
      cssls = {},
      dartls = {},
      jsonls = {},
      jdtls = {},
      marksman = {},
      volar = {},
      rust_analyzer = {
        cmd = {
          "rustup",
          "run",
          "stable",
          "rust_analyzer",
        },
      },
      ocamllsp = {},
    }

    --cmp provides aditional capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local on_attach = function(_client, buffer_number)
      keybinds(buffer_number)
    end

    for name, config in pairs(servers) do
      require("lspconfig")[name].setup({
        capabilities = default_capabilities,
        on_attach = on_attach,
        settings = config.cmd,
      })
    end

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      border = "rounded",
      sources = {
        --formatting
        formatting.google_java_format,
        formatting.prettier,
        formatting.stylua,
        formatting.ocamlformat,
        formatting.clang_format,
      },
      autostart = true,
    })

    --Borderd for LspInfo ui
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
