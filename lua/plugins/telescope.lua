-- Telescope itself (plugin, default keymaps, and telescope-fzf-native) is enabled
-- via the LazyVim "editor.telescope" extra in lazyvim.json. This file only layers
-- small ergonomic tweaks on top; it does NOT re-declare the plugin from scratch.
return {
  "nvim-telescope/telescope.nvim",
  -- Function form so we MERGE into LazyVim's opts instead of replacing them.
  opts = function(_, opts)
    local actions = require("telescope.actions")
    opts.defaults = opts.defaults or {}
    opts.defaults.mappings = opts.defaults.mappings or {}
    -- <C-j>/<C-k> to move the selection while typing, next to the default <C-n>/<C-p>.
    opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i or {}, {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    })
  end,
}
