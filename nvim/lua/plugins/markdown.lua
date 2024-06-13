return {
	{
		"ellisonleao/glow.nvim",
		config = function()
			require("glow").setup()
			vim.keymap.set("n", "<C-g>", ":Glow <CR>")
			vim.api.nvim_set_hl(0, "@text.code", { bg = "#000FFF" })
		end,
	},
	-- {
	--   "lukas-reineke/headlines.nvim",
	--   dependencies = "nvim-treesitter/nvim-treesitter",
	--   config = true, -- or `opts = {}`
	-- },
}
