return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "hrsh7th/nvim-cmp",
      "williamboman/mason-lspconfig.nvim",
    },

    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local keybinds = require("user.keybinds").lsp_keybinds

      require('neodev').setup()

      local servers = {
        bashls = {},
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" } -- exclude "proto"
        },
        cssls = {},
        dockerls = {},
        gradle_ls = {},
        lua_ls = {},
        rust_analyzer = {
          diagnostics =  {
             refreshSupport = false,
          }
        },
        jsonls = {},
        -- ocamllsp = {},
        yamlls = {},
        pyright = {},
        pbls = {},
        tailwindcss = {},
        ts_ls = {},
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))


      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = servers_to_install
      })


      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- setup gdscript
      lspconfig.gdscript.setup(default_capabilities)

      local on_attach = function(_client, buffer_number)
        keybinds(buffer_number)
      end

      --for name, config in pairs(servers) do
      --  require("lspconfig")[name].setup({
      --    capabilities = default_capabilities,
      --    on_attach = on_attach,
      --    settings = config.cmd,
      --  })
      --  --Borderd for LspInfo ui
      --end

      for name, config in pairs(servers) do
        lspconfig[name].setup(vim.tbl_extend("force", {
          capabilities = default_capabilities,
          on_attach = on_attach,
        }, config))
      end

      require("lspconfig.ui.windows").default_options.border = "rounded"
    end
  },
}
