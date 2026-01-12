-- Global keymaps (non-plugin specific)

-- Clear search highlights
vim.keymap.set("n", "ss", ":noh<CR>", { desc = "Clear search highlights" })

-- Navigation
vim.keymap.set("n", "E", "$", { desc = "Jump to end of line" })
vim.keymap.set("n", "B", "^", { desc = "Jump to beginning of line" })

return {}
