-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- TypeScript specific
map("n", "<leader>tfi", ":TSToolsAddMissingImports<CR>", { desc = "Add Missing Imports" })
map("n", "<leader>tfo", ":TSToolsOrganizeImports<CR>", { desc = "Organize Imports" })
map("n", "<leader>tfr", ":TSToolsRenameFile<CR>", { desc = "Rename File" })
map("n", "<leader>tfs", ":TSToolsSortImports<CR>", { desc = "Sort Imports" })
