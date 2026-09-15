-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
map("n", "<leader>rn", ":set relativenumber!<CR>", { desc = "Toggle relative numbers", silent = true })
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })

-- Tab + arrow: navigate between editor windows without stealing Tab alone.
map("n", "<Tab><Right>", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<Tab><Left>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
map("n", "<C-Right>", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<C-Left>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
map("n", "<C-PageDown>", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<C-PageUp>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
-- LazyVim's top bar shows buffers, not Vim tabpages.
map("n", "]b", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "[b", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
