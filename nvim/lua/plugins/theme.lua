return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = false,
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
--
--
-- return {
-- 	"folke/tokyonight.nvim",
-- 	opts = {
-- 		transparent = false,
-- 		style = "day",
-- 		styles = {
-- 			sidebars = "transparent",
-- 			floats = "transparent",
-- 		},
-- 	},
-- }
