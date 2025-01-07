vim.g.mapleader = " "
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.api.nvim_create_user_command("PS", "Lazy install", {})
vim.keymap.set("n", "<C-CR>", ":o<CR>")

vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("QA", "qa", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WA", "wa", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("W", "w", {})

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("v", "s", "<Nop>")
vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<leader><return>", "ciw")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>;", "q:")

-- Resize windows
vim.keymap.set("n", "=", [[<cmd>vertical resize +10<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -10<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +4<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -4<cr>]])

-- Map '>' and '<' in visual mode to keep selection after indenting in NeoVim
vim.api.nvim_set_keymap('x', '>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<', '<gv', { noremap = true, silent = true })

-- Shortcut for golang error handling
vim.api.nvim_set_keymap('n', '<leader>ge', 'oif err != nil {<CR>}<Esc>O', { noremap = true, silent = true })

-- LEAVE TERMINAl
-- vim.api.nvim_set_keymap('t', '<esc><esc>', [[<C-\><C-n>]], { noremap = true })

-- Clear nohl
vim.keymap.set('n', '<leader>\\', ':nohl<CR>', { silent = true })

vim.keymap.set("n", "<leader>pn", vim.cmd.Ex)
