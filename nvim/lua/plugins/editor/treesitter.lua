return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/playground" },
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
