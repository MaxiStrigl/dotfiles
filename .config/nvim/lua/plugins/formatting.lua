return {
	"nvimtools/none-ls.nvim",

	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},

	config = function()
		local null_ls = require("null-ls")

		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		require("mason-null-ls").setup({
			ensure_installed = {
				"prettier", --js/ts formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
				"shfmt", -- shell formatter
				"checkmake", -- linter for makefiles
				"ruff", -- litner for python
				"mypy", -- static analyisis for python
			},
			automatic_installation = true,
		})

		local sources = {
			diagnostics.checkmake,
			diagnostics.mypy,
			formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
			formatting.stylua,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),
		}

		local augrpoup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			border = "rounded",
			sources = sources,
			autostart = true,
			debug = true,
			on_attach = function(client, bufnr)
				vim.api.nvim_clear_autocmds({ group = augrpoup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augrpoup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end,
		})
	end,
}
