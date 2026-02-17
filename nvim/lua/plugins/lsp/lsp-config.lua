return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"gopls",
					"golangci_lint_ls",
					"ocamllsp",
					"marksman",
					"pylsp",
					"bashls",
					"java_language_server",
					"jinja_lsp",
					"dockerls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Helper to find venv pylsp
			local function find_venv_pylsp()
				local root = vim.fn.getcwd()
				local venv_paths = {
					root .. "/.venv/bin/pylsp",
					root .. "/venv/bin/pylsp",
					root .. "/.env/bin/pylsp",
				}

				for _, path in ipairs(venv_paths) do
					if vim.fn.filereadable(path) == 1 then
						return path
					end
				end
				return "pylsp" -- Fallback to system pylsp
			end

			-- Configure LSP servers using NeoVim 0.11+ vim.lsp.config API

			-- java_language_server configuration
			vim.lsp.config.java_language_server = {
				cmd = { "java-language-server" },
			}

			-- lua_ls configuration
			vim.lsp.config.lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}

			-- pylsp configuration - auto-detects venv pylsp
			vim.lsp.config.pylsp = {
				cmd = { find_venv_pylsp() },
				settings = {
					pylsp = {
						plugins = {
							jedi_completion = { enabled = true },
							jedi_hover = { enabled = true },
							jedi_references = { enabled = true },
							jedi_signature_help = { enabled = true },
							jedi_symbols = { enabled = true },
							pycodestyle = { enabled = false },
							pyflakes = { enabled = false },
							pylint = { enabled = false },
							rope_autoimport = { enabled = false },
							type_definition = { enabled = false }, -- Disable missing plugin in older pylsp
						},
					},
				},
			}

			-- marksman configuration
			vim.lsp.config.marksman = {}

			-- ts_ls configuration
			vim.lsp.config.ts_ls = {}

			-- bashls configuration
			vim.lsp.config.bashls = {}

			-- ocamllsp configuration
			vim.lsp.config.ocamllsp = {
				cmd = { "ocamllsp" },
				filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
				root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" },
			}

			-- gopls configuration
			vim.lsp.config.gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = { "go.work", "go.mod", ".git" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			}

			-- jinja_lsp configuration
			vim.lsp.config.jinja_lsp = {}

			-- dockerls configuration
			vim.lsp.config.dockerls = {}

			-- golangci_lint_ls configuration
			vim.lsp.config.golangci_lint_ls = {}

			-- golangci_lint_ls configuration
			vim.lsp.config.ruby_lsp = {}

			-- Enable the LSP servers
			vim.lsp.enable("java_language_server")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("pylsp")
			vim.lsp.enable("marksman")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("bashls")
			vim.lsp.enable("ocamllsp")
			vim.lsp.enable("gopls")
			vim.lsp.enable("jinja_lsp")
			vim.lsp.enable("dockerls")
			vim.lsp.enable("golangci_lint_ls")
			vim.lsp.enable("ruby_lsp")

			-- Keymaps (using consistent vim.keymap.set)
			local nmap = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
			end

			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			nmap("K", vim.lsp.buf.hover, "Hover documentation")
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		end,
	},
}
