return {
  "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git",
  event = { "BufReadPre", "BufNewFile" }, -- Activate when a file is created/opened
  config = function()
    require("gitlab").setup({
      statusline = {
        enabled = true,
      },
      code_suggestions = {
        auto_filetypes = {
          "c",          -- C
          "cpp",        -- C++
          "csharp",     -- C#
          "go",         -- Golang
          "java",       -- Java
          "javascript", -- JavaScript
          "javascriptreact", -- JavaScript React
          "kotlin",     -- Kotlin
          "markdown",   -- Markdown
          "objective-c", -- Objective-C
          "objective-cpp", -- Objective-C++
          "php",        -- PHP
          "python",     -- Python
          "ruby",       -- Ruby
          "rust",       -- Rust
          "scala",      -- Scala
          "sql",        -- SQL
          "swift",      -- Swift
          "terraform",  -- Terraform
          "typescript", -- TypeScript
          "typescriptreact", -- TypeScript React
          "sh",         -- Shell scripts
          "html",       -- HTML
          "css",        -- CSS
        },
        enabled = true,
        fix_newlines = true,
        lsp_binary_path = "node",
        offset_encoding = "utf-16",
        redact_secrets = false,
      },
      resource_editing = {
        enabled = true,
      },
    })
    vim.keymap.set("n", "<leader>dc", "<Plug>(GitLabToggleCodeSuggestions)")
  end,
}
