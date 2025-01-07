require("jwtly10.set")
require("jwtly10.remap")
require("jwtly10.lazy_init")

local augroup = vim.api.nvim_create_augroup
local JGroup = augroup('jwtly10', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

autocmd('LspAttach', {
    group = JGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        local fzf = require('fzf-lua')

        -- Native LSP maps
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "gt", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>ca", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "gu", function()
            vim.lsp.buf.usages()
        end, opts)
        vim.keymap.set("n", "<leader>rn", function()
            vim.lsp.buf.rename()
        end, opts)

        -- Fzf LSP maps
        vim.keymap.set("n", "gd", function()
            fzf.lsp_definitions({ jump_to_single_result = true })
        end, opts)
        vim.keymap.set("n", "gi", function()
            fzf.lsp_implementations({ jump_to_single_result = true })
        end, opts)
        vim.keymap.set("n", "gr", function()
            fzf.lsp_references()
        end, opts)
    end
})
