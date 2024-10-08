local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local M = {}
--- Telescope
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>f/", require("telescope.builtin").live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "Find recently opened files" })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find,
  { desc = "Fuzzy find current buffer" })
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Find Help" })

vim.keymap.set("n", "<leader>fc", function()
    require("telescope.builtin").commands(
      require("telescope.themes").get_dropdown(
        { previewer = false, }))
  end,
  { desc = "Find Commands" })


vim.keymap.set("n", "<leader>cs", function()
    require("telescope.builtin").spell_suggest(
      require("telescope.themes").get_dropdown(
        { previewer = false, }))
  end,
  { desc = "Search spelling suggestions" })


--- Oil


--- LSP
M.lsp_keybinds = function(buffer_number)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Documentation", buffer = buffer_number })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = " Documentation ", buffer = buffer_number })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = " Code Action ", buffer = buffer_number })
  vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = " Format Document ", buffer = buffer_number })
end

--- DAP
vim.keymap.set("n", "<Leader>q", ":lua require'dapui'.close()<CR>", { desc = "close DAP UI" })

vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>", { desc = "Continue Debug" })
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "Terminate Debug" })
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<Leader>di", ":DapStepInto<CR>", { desc = "Step Over" })

--Map jj to <ESC>
vim.keymap.set('i', "jj", "<ESC>", { desc = "escape" })

--Map FF to <ESC>la
vim.keymap.set('i', "FF", "<ESC>la")

--clear search highlights
vim.keymap.set('n', "<leader>no", ":noh<CR>", { desc = "Clear search highlights" })

--Harpoon keybinds
vim.keymap.set('n', "<leader>ho", function()
  harpoon_ui.toggle_quick_menu()
end, { desc = "Toggle Harpoon Menu" })

vim.keymap.set('n', "<leader>ha", function()
  harpoon_mark.add_file()
end, { desc = "Add file to harpoon" })

vim.keymap.set('n', "<leader>hr", function()
  harpoon_mark.remove_file()
end, { desc = "Remove file from harpoon" })

vim.keymap.set('n', "<leader>hc", function()
  harpoon_mark.clear_all()
end, { desc = "Clear all harpoon marks" })

vim.keymap.set('n', "<leader>1", function()
  harpoon_ui.nav_file(1)
end, { desc = "Go to harpoon mark 1" })

vim.keymap.set('n', "<leader>2", function()
  harpoon_ui.nav_file(2)
end, { desc = "Go to harpoon mark 2" })

vim.keymap.set('n', "<leader>3", function()
  harpoon_ui.nav_file(3)
end, { desc = "Go to harpoon mark 3" })

vim.keymap.set('n', "<leader>4", function()
  harpoon_ui.nav_file(4)
end, { desc = "Go to harpoon mark 4" })

vim.keymap.set('n', "<leader>5", function()
  harpoon_ui.nav_file(5)
end, { desc = "Go to harpoon mark 5" })

--Git keybinds
vim.keymap.set('n', '<leader>gl', ':LazyGit<CR>', { desc = 'Open LazyGit' })
vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { desc = 'Toggle Git Blame' })

vim.keymap.set('v', '<leader>y', '"+y')

-- Goto Definition
vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")

--Undotree keybinds
vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })

--Trouble
vim.keymap.set("n", "<leader>dd", function() require("trouble").toggle("diagnostics") end,
  { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>dq", function() require("trouble").toggle("quickfix") end, { desc = "Quickfix" })


--ToDo comments
vim.keymap.set("n", "<leader>ft", ':TodoTelescope<CR>', { desc = 'Find ToDos' })
vim.keymap.set("n", "<leader>dt", ':TodoTrouble<CR>', { desc = 'List ToDos' })


return M

-- delete file in current buffer
