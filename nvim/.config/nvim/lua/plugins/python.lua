return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                diagnosticSeverityOverrides = {
                  reportGeneralTypeIssues = "warning",
                  reportOptionalMemberAccess = "warning",
                  reportOptionalCall = "warning",
                  reportOptionalIterable = "warning",
                  reportOptionalContextManager = "warning",
                  reportOptionalOperand = "warning",
                },
              },
            },
          },
        },
        ruff_lsp = {
          init_options = {
            settings = {
              args = {},
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
      },
    },
  },
}
