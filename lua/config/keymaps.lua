-- Keymaps are automatically loaded on the VeryLazy event
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Buffer cycling with Ctrl+H and Ctrl+L
vim.keymap.set("n", "<C-h>", "<cmd>bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
