local jdtls = require('jdtls')
local home = os.getenv("HOME")
local jdtls_dap = require('jdtls.dap')


local on_attach = function(_, bufnr)
  jdtls.setup_dap({ hotcodereplace = "auto" })
  jdtls_dap.setup_dap_main_class_configs()
end

local bundles = {
  vim.fn.glob(
    "~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}

vim.list_extend(bundles,
  vim.split(vim.fn.glob("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", true), "\n"))


local config = {

  cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      project = {
        referencedLibraries = {
          home .. '/.gradle/caches/modules-2/files-2.1/junit/junit/4.13.2/**/*.jar',
        }
      }
      -- Other settings
    }
  },
}

config.on_attach = on_attach

local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true


config['init_options'] = {
  bundles = bundles,
}

require("jdtls").start_or_attach(config);

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4


vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Documentation" })
vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = " Documentation " })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = " Code Action " })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = " Format Document " })


vim.keymap.set("n", "<leader>dg", require("jdtls.tests").generate, { desc = "Generate Tests" })
