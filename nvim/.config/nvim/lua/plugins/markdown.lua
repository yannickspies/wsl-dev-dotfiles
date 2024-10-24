return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>cp", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  -- Better lists, bullets, checkboxes
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
    },
    config = function()
      require("autolist").setup({
        -- list types that will be used
        lists = {
          markdown = { "1.", "-", "*", "+", ">" },
          text = { "1.", "-", "*", "+", ">" },
        },
        -- automatically continue lists when pressing Enter
        enabled = true,
      })
      -- Keymaps
      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
    end,
  },

  -- Table mode for easy table formatting
  {
    "dhruvasagar/vim-table-mode",
    cmd = "TableModeToggle",
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
    },
  },

  -- Configure formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
      },
    },
  },
}
