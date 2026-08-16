-- Keymaps are automatically loaded on the VeryLazy event
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Buffer cycling with Ctrl+H and Ctrl+L
vim.keymap.set("n", "<C-h>", "<cmd>bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })

local function focus_line_diagnostic()
  local _, winid = vim.diagnostic.open_float(nil, {
    focus = true,
    scope = "line",
    border = "rounded",
  })

  if winid and vim.api.nvim_win_is_valid(winid) then
    vim.api.nvim_set_current_win(winid)
  end
end

vim.keymap.set("n", "gz", focus_line_diagnostic, { desc = "Focus line diagnostic" })
vim.keymap.set("n", "<leader>w", "<C-w>p", { noremap = true, silent = true, desc = "Previous window" })
