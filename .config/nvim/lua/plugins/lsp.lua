return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "hrsh7th/nvim-cmp",
      "williamboman/mason-lspconfig.nvim",
    },

    config = function()
      local lspconfig = require('lspconfig')
      local keybinds = require("user.keybinds").lsp_keybinds

      require('neodev').setup()

      local servers = {
        bashls = {},
        clangd = {},
        lua_ls = {},
        rust_analyzer = {},
        jsonls = {},
        ocamllsp = {},
        yamlls = {},
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

      local on_attach = function(_client, buffer_number)
        keybinds(buffer_number)
      end

      for name, config in pairs(servers) do
        require("lspconfig")[name].setup({
          capabilities = default_capabilities,
          on_attach = on_attach,
          settings = config.cmd,
        })
        --Borderd for LspInfo ui
      end

      require("lspconfig.ui.windows").default_options.border = "rounded"
    end
  },
}
