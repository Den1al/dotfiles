-- Core Vim options

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- UI
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "0"

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Behavior
vim.opt.clipboard = "unnamed"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.completeopt = "menu,menuone"

-- Leader key
vim.g.mapleader = " "

return {}
