return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "typescript",
          "tsx",
          "javascript",
          "python",
          "markdown",
          "markdown_inline",
          "html",
          "json",
          "yaml",
          "css",
          "bash",
        })
      end
    end,
  },
}
