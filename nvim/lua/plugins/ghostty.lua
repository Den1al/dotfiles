return {
	"isak102/ghostty.nvim",
	config = function()
		require("ghostty").setup({
			-- The autocmd pattern matched against the filename of the buffer. If this pattern
			-- matches, ghostty.nvim will run on save in that buffer. This pattern is passed to
			-- nvim_create_autocmd, check `:h autocmd-pattern` for more information. Can be
			-- either a string or a list of strings
			file_pattern = "**/ghostty/config",
			-- The ghostty executable to run.
			ghostty_cmd = "ghostty",
			-- The timeout in milliseconds for the check command.
			-- If the command takes longer than this it will be killed.
			check_timeout = 1000,
		})
	end,
}
