return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" },
	config = function()
		local opts = {
			options = {
				theme = "modus-vivendi",
			},
			extensions = { "fugitive", "quickfix", "neo-tree", "lazy", "mason", "nvim-dap-ui", "oil", "trouble" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		}

		local trouble = require("trouble")
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			-- The following line is needed to fix the background color
			-- Set it to the lualine section you want to use
			hl_group = "lualine_c_normal",
		})

		table.insert(opts.sections.lualine_c, {
			symbols.get,
			cond = symbols.has,
		})

		require("lualine").setup(opts)
	end,
}
