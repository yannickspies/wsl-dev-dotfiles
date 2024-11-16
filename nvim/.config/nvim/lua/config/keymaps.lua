-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- TypeScript specific
map("n", "<leader>tfi", ":TSToolsAddMissingImports<CR>", { desc = "Add Missing Imports" })
map("n", "<leader>tfo", ":TSToolsOrganizeImports<CR>", { desc = "Organize Imports" })
map("n", "<leader>tfr", ":TSToolsRenameFile<CR>", { desc = "Rename File" })
map("n", "<leader>tfs", ":TSToolsSortImports<CR>", { desc = "Sort Imports" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Center cursor when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Select all text (equivalent to ggVG)
map("n", "<C-a>", "ggVG", { desc = "Select all text" })

-- Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
