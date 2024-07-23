return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- Optional
		{
			"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
			opts = {},
		},
	},
	config = function()
		require("codecompanion").setup({
			adapters = {
				anthropic = require("codecompanion.adapters").use("anthropic", {
					env = {
						api_key = "ANTHROPIC_TOKEN",
					},
				}),
			},
			strategies = {
				chat = {
					adapter = "anthropic",
				},
				inline = {
					adapter = "anthropic",
				},
				agent = {
					adapter = "anthropic",
				},
			},
		})
		vim.api.nvim_set_keymap("n", "<C-c>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("v", "<C-c>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>c", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("v", "<leader>c", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
	-- "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git",
	-- event = { "BufReadPre", "BufNewFile" }, -- Activate when a file is created/opened
	-- config = function()
	--   require("gitlab").setup({
	--     statusline = {
	--       enabled = true,
	--     },
	--     code_suggestions = {
	--       auto_filetypes = {
	--         "c",          -- C
	--         "cpp",        -- C++
	--         "csharp",     -- C#
	--         "go",         -- Golang
	--         "java",       -- Java
	--         "javascript", -- JavaScript
	--         "javascriptreact", -- JavaScript React
	--         "kotlin",     -- Kotlin
	--         "markdown",   -- Markdown
	--         "objective-c", -- Objective-C
	--         "objective-cpp", -- Objective-C++
	--         "php",        -- PHP
	--         "python",     -- Python
	--         "ruby",       -- Ruby
	--         "rust",       -- Rust
	--         "scala",      -- Scala
	--         "sql",        -- SQL
	--         "swift",      -- Swift
	--         "terraform",  -- Terraform
	--         "typescript", -- TypeScript
	--         "typescriptreact", -- TypeScript React
	--         "sh",         -- Shell scripts
	--         "html",       -- HTML
	--         "css",        -- CSS
	--       },
	--       enabled = true,
	--       fix_newlines = true,
	--       lsp_binary_path = "node",
	--       offset_encoding = "utf-16",
	--       redact_secrets = false,
	--     },
	--     resource_editing = {
	--       enabled = true,
	--     },
	--   })
	--   vim.keymap.set("n", "<leader>dc", "<Plug>(GitLabToggleCodeSuggestions)")
	-- end,
}
