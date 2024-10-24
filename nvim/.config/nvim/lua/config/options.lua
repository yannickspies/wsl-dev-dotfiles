-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- Line numbers and indentation
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8 -- Keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.smartindent = true -- Insert indents automatically

-- Search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search contains uppercase

-- Appearance
opt.termguicolors = true -- True color support
opt.wrap = false -- Disable line wrap
opt.cursorline = true -- Highlight current line
opt.signcolumn = "yes" -- Always show sign column

-- Behavior
opt.undofile = true -- Persistent undo history
opt.updatetime = 250 -- Faster completion
opt.timeout = true -- Enable timeout for mappings
opt.timeoutlen = 300 -- Time to wait for mapped sequence to complete
opt.clipboard = "unnamedplus" -- Use system clipboard

vim.opt.conceallevel = 2 -- Hide markup for bold, italic etc.

-- Markdown specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Enable word wrap
    vim.opt_local.wrap = true
    -- Enable spell checking
    vim.opt_local.spell = true
    -- Set text width for auto wrapping
    vim.opt_local.textwidth = 80
  end,
})
