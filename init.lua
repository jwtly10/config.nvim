require("jwtly10")

-- Need to disable netrw for nvim-tree to work
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if vim.v.argv[3] and vim.fn.isdirectory(vim.v.argv[3]) == 1 then
    vim.api.nvim_set_current_dir(vim.v.argv[3])
end
