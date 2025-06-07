-- Load Packer and define all plugins in a single startup block
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- adding test comment to test my git

    -- Mason for managing LSP servers
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- Update registry stuff
    }

    -- Discord presence
    use 'andweeb/presence.nvim'

    -- Treesitter for better syntax highlighting
    use "nvim-treesitter/nvim-treesitter"

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Alpha-nvim splash screen
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }

    -- LSP config
    use 'neovim/nvim-lspconfig'

    -- Git integration
    use 'airblade/vim-gitgutter'

    -- Completion engine (nvim-cmp and dependencies)
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip', -- Required for snippet support
        }
    }

    -- Multi-cursor support
    use 'mg979/vim-visual-multi'

    -- File explorer
    use 'nvim-tree/nvim-tree.lua'

    -- Theme
    use 'navarasu/onedark.nvim'
end)

-- General Neovim settings
vim.opt.number = true          -- Show line numbers
vim.opt.tabstop = 2            -- Number of spaces a tab character occupies
vim.opt.shiftwidth = 2         -- Number of spaces for each level of indentation
vim.opt.expandtab = true       -- Use spaces instead of tabs

-- Keymapping for NvimTree
vim.keymap.set('n', '©', ':NvimTreeOpen<CR>', { noremap = true, silent = true })

-- Mason setup
require("mason").setup()

-- Nvim-cmp setup
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Cmdline completion
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- LSP setup
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.keymap.set("n", ",", vim.diagnostic.open_float, { noremap = true, silent = true })

-- Configure clangd
lspconfig.clangd.setup {
  capabilities = capabilities,
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
  filetypes = { 'c', 'cpp' },
  root_dir = require('lspconfig.util').root_pattern('.clangd', 'compile_commands.json', '.git'),
}

-- Configure tsserver (JavaScript/TypeScript)
lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts) -- Go to definition
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)       -- Show hover info
    end,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = lspconfig.util.root_pattern("package.json", ".git") or vim.fn.getcwd(),
}

-- Nvim-tree setup
require("nvim-tree").setup {
    filters = {
        dotfiles = false,
    }
}

-- Web devicons setup
require("nvim-web-devicons").setup {
    default = true
}

-- Onedark theme setup
require('onedark').setup {
    style = 'dark',
    transparent = true,
}
require('onedark').load()

-- Discord presence setup
require("presence").setup({
    auto_update = true,
    neovim_image_text = "The One True Text Editor",
    main_image = "neovim",
    client_id = "793271441293967371",
    log_level = nil,
    debounce_timeout = 10,
    enable_line_number = false,
    blacklist = {},
    buttons = true,
    file_assets = {},
    show_time = true,
    editing_text = "Editing %s",
    file_explorer_text = "Browsing %s",
    git_commit_text = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text = "Reading %s",
    workspace_text = "Working on %s",
    line_number_text = "Line %s out of %s",
})

-- Treesitter setup
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c" }, -- Add more languages if needed
    highlight = { enable = true },
}
