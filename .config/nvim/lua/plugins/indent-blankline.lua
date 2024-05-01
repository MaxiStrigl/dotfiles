return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufEnter",
	main = "ibl",
	opts = {},
	config = function()
		require("ibl").setup({
			scope = {
				enabled = false,
			},
		})
	end,
}
