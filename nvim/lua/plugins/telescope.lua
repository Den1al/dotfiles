return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			local better_find_files = function()
				builtin.find_files({
					find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
					previewer = false,
				})
			end

			vim.keymap.set("n", "<leader>ff", better_find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
			-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })

			-- this will setup <leader>fg for live grep
			require("config.telescope.multigrep").setup()
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
