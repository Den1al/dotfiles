return {
	"mikesmithgh/kitty-scrollback.nvim",
	enabled = true,
	lazy = true,
	cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
	event = { "User KittyScrollbackLaunch" },
	-- version = '*', -- latest stable version, may have breaking changes if major version changed
	-- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
	config = function()
		require("kitty-scrollback").setup({
			-- global configuration
			{
				status_window = {
					autoclose = true,
				},
			},
			-- builtin configuration override
			ksb_builtin_get_text_all = {
				kitty_get_text = {
					ansi = true,
				},
			},
			-- user defined configuration table
			myconfig = {
				kitty_get_text = {
					ansi = true,
				},
			},
			-- user defined configuration function
			myfnconfig = function(kitty_data)
				return {
					kitty_get_text = {
						extent = "all",
					},
				}
			end,
		})
	end,
}
