vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.cmd.startinsert()
	end,
})

-- Right terminal
vim.keymap.set("n", "<leader>rt", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.api.nvim_win_set_width(0, 60)
end)

-- Small Terminal below
vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end)

-- Leave terminal with esc
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
