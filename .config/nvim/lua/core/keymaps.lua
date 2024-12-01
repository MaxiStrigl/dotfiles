-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar's default behaviour in Normal/Visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local opts = { noremap = true, silent = true }

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Center cursor when virtical scoll
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Center cursor veritcally when Searching
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)

-- Manage Splits
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)       -- Split vertical
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)       -- Split horizontal
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)      -- Make splits equal size
vim.keymap.set("n", "<leader>xs", "<:close<CR>", opts) -- Close split

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", ":set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting over text
vim.keymap.set("v", "p", '"_dP', opts)
