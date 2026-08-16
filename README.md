# Neovim Reference

This config is a small LazyVim-based setup with a few local customizations on top.

## Local custom behavior

- Leader key: `Space`
- Clipboard: `unnamedplus`
  - Normal yanks and pastes use the system clipboard
  - Example: `yy`, `y`, and `p` work without `"+`
- Line numbers:
  - Absolute numbers enabled
  - Relative numbers disabled
- Theme: `onedark` with transparency enabled

## Custom keymaps

- `gz`
  - Open diagnostics for the current line
  - Move focus into the diagnostic float automatically
- `Space w`
  - Jump back to the previous window
  - Useful after opening the diagnostic float
- `Ctrl-h`
  - Previous buffer
- `Ctrl-l`
  - Next buffer

## Diagnostic workflow

Recommended flow:

1. Move cursor onto the line with the error
2. Press `gz`
3. Yank text from the floating diagnostic window if needed
4. Press `Space w` to jump back to your code

Other useful commands:

- `:messages`
  - Show recent Neovim messages and errors
- `:LspInfo`
  - Show active LSP clients for the current buffer
- `:checkhealth`
  - General Neovim health report
- `:checkhealth vim.lsp`
  - LSP-specific health report
- `:close`
  - Close the current floating window or split

## Telescope (fuzzy finder)

Telescope is enabled via the LazyVim `editor.telescope` extra (see `lazyvim.json`),
which also pulls in `telescope-fzf-native` for fast sorting. A picker is a floating
prompt + results list + preview: type to fuzzy-filter, then act on the selection.

Common LazyVim keymaps (confirm the live list with `Space` then `f`/`s`, or search
all mappings with `Space s k`):

- `Space Space` or `Space f f`
  - Find files (project root)
- `Space f F`
  - Find files (current working dir)
- `Space f b`
  - Open buffers
- `Space f r`
  - Recent files
- `Space /` or `Space s g`
  - Live grep across the project (needs `ripgrep`)
- `Space s w`
  - Grep the word under the cursor (or the visual selection)
- `Space s k`
  - Search all keymaps
- `Space s h`
  - Search help pages
- `Space s R`
  - Resume the last picker with its previous state
- `Space ,`
  - Switch buffer

Inside a picker:

- `Ctrl-n` / `Ctrl-p` (or `Ctrl-j` / `Ctrl-k`, added locally in `lua/plugins/telescope.lua`)
  - Move down / up the results
- `Enter`
  - Open the selection
- `Ctrl-v` / `Ctrl-x` / `Ctrl-t`
  - Open in a vertical split / horizontal split / new tab
- `Ctrl-u` / `Ctrl-d`
  - Scroll the preview
- `Tab`
  - Toggle multi-select; `Ctrl-q` sends results to the quickfix list
- `Esc`
  - Enter the picker's normal mode (vim motions); `Esc` again or `q` closes it

## Core plugins in use

These are the main moving parts in this config:

- `LazyVim`
  - Base distro and default keymap/plugin layer
- `lazy.nvim`
  - Plugin manager
  - Use `:Lazy` to install, update, clean, and inspect plugins
- `nvim-lspconfig`
  - LSP client configuration
- `mason.nvim`
  - Installs LSP servers, formatters, and related tooling
  - Use `:Mason`
- `mason-lspconfig.nvim`
  - Bridges Mason packages into LSP setup
- `conform.nvim`
  - Formatting
  - Use `:ConformInfo`
- `nvim-treesitter`
  - Better parsing, highlighting, and text objects
- `gitsigns.nvim`
  - Inline git signs and hunk actions
- `trouble.nvim`
  - Diagnostics and list UI
- `grug-far.nvim`
  - Project-wide search and replace
- `telescope.nvim`
  - Fuzzy finder for files, grep, buffers, symbols, and keymaps (via the LazyVim extra)
- `flash.nvim`
  - Faster navigation/jumping
- `which-key.nvim`
  - Shows available keymaps after prefix keys
- `noice.nvim`
  - Improved command line, messages, and popup UI
- `snacks.nvim`
  - Provides some LazyVim utility UI, including explorer behavior
- `lualine.nvim`
  - Statusline
- `onedark.nvim`
  - Colorscheme

## LSP/tooling configured here

Installed/configured language tooling includes:

- `pyright`
- `ruff`
- `typescript-language-server`
- `eslint-lsp`
- `prettierd`
- `sqlls`
- `css-lsp`
- `yaml-language-server`
- `dockerfile-language-server`

Notes:

- Python may show duplicate diagnostics from both `pyright` and `ruff`
- TypeScript is configured as `ts_ls`
- YAML includes Azure pipeline schema support for `azure-*.yml`

## Useful basics

- `Space`
  - Opens the LazyVim keymap namespace via which-key
- `:Lazy`
  - Plugin manager UI
- `:Mason`
  - External tools installer UI
- `:LspInfo`
  - Check whether a server actually attached to the current file
- `:verbose nmap {key}`
  - See what a key is mapped to and where it was defined
  - Example: `:verbose nmap gz`
- `:e ~/.config/nvim/lua/config/keymaps.lua`
  - Edit custom keymaps
- `:e ~/.config/nvim/lua/config/options.lua`
  - Edit local options
- `:e ~/.config/nvim/lua/plugins/lsp.lua`
  - Edit LSP and Mason config

## Relevant local files

- `init.lua`
  - Entry point
- `lua/config/options.lua`
  - Basic editor options
- `lua/config/keymaps.lua`
  - Local keymaps
- `lua/plugins/lsp.lua`
  - Mason + LSP configuration
- `lua/plugins/themes.lua`
  - Theme setup
- `lua/plugins/telescope.lua`
  - Telescope ergonomic tweaks (in-picker `Ctrl-j`/`Ctrl-k`)

## Reloading config

After changing Lua config, either restart Neovim or source the file manually.

Examples:

- `:source ~/.config/nvim/lua/config/keymaps.lua`
- `:source ~/.config/nvim/lua/config/options.lua`

For larger plugin changes, restarting Neovim is the safer move.
