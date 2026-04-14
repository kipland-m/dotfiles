return {
  -- Correct package name in LazyVim v15
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "eslint-lsp",
        "prettierd",
        "pyright",
        "ruff",
        "sqlls",
        "css-lsp",
        "yaml-language-server",
        "dockerfile-language-server",
      },
    },
  },

  -- Use opts as a function to safely merge with LazyVim's base config
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Inlay hints (already enabled by default in LazyVim v15, but be explicit)
      opts.inlay_hints = vim.tbl_deep_extend("force", opts.inlay_hints or {}, {
        enabled = true,
      })

      -- Add servers
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "standard",
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {},
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
        eslint = {},
        sqlls = {},
        cssls = {},
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-*.yml",
              },
            },
          },
        },
      })

      return opts
    end,
  },
}
