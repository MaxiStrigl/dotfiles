-- Enable relative line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- Set Tabs to 2 spaces 
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Enable text wrap
vim.opt.wrap = true

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable persistent undo history
vim.opt.undofile = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 8

-- Place a column line
vim.opt.colorcolumn = "80"
