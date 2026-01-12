-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.utils.window-resize")

-- Load plugins (lazy.nvim auto-discovers subdirectories)
require("lazy").setup({
  spec = {
    { import = "plugins.lsp" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.navigation" },
    { import = "plugins.git" },
    { import = "plugins.ai" },
    { import = "plugins.debug" },
    { import = "plugins.tools" },
    { import = "plugins.terminal" },
  },
})
