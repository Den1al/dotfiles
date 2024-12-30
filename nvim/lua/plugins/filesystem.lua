return {
  -- temp disabled
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")
  --     require("neo-tree").setup({
  --       window = {
  --         position = "right",
  --       },
  --       close_if_last_window = true,
  --       filesystem = {
  --         filtered_items = {
  --           hide_dotfiles = false,
  --           hide_gitignored = false,
  --           group_empty_dirs = true,
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
          end,
        },
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
        },
        win_options = {
          wrap = true,
          winblend = 0,
        },
        keymaps = {
          ["<C-c>"] = false,
          ["q"] = "actions.close",
        },
      })

      vim.keymap.set("n", "-", require("oil").toggle_float, { desc = "Open parent directory" })
    end,
  },
}
