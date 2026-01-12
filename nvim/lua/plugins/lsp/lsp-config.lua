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
      local lspconfig = require("lspconfig")

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

      -- Configure LSP servers

      -- Lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Python (auto-detects venv)
      lspconfig.pylsp.setup({
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
      })

      -- Go
      lspconfig.gopls.setup({
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })

      -- OCaml
      lspconfig.ocamllsp.setup({
        cmd = { "ocamllsp" },
        filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
        root_dir = lspconfig.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
      })

      -- Simple setups for servers with default config
      local simple_servers = { "ts_ls", "bashls", "marksman", "jinja_lsp", "java_language_server", "dockerls", "golangci_lint_ls" }
      for _, server in ipairs(simple_servers) do
        lspconfig[server].setup({})
      end

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
