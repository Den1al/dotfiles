return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")
    require("neo-tree").setup({
      window = {
        position = "right",
      },
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          group_empty_dirs = true,
        },
      },
    })
  end,
}
