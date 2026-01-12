-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- UI
vim.opt.number = true
vim.opt.foldcolumn = "0"
vim.opt.clipboard = "unnamed"

-- Leader key
vim.g.mapleader = " "

-- Keymaps
vim.keymap.set("n", "ss", ":noh<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "E", "$", { desc = "Jump to end of line" })
vim.keymap.set("n", "B", "^", { desc = "Jump to beginning of line" })

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = false

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

vim.o.completeopt = "menu,menuone"
