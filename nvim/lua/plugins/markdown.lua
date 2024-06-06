return {
	"ellisonleao/glow.nvim",
	config = function()
		require("glow").setup()
		vim.keymap.set("n", "<C-g>", ":Glow <CR>")
	end,
}
