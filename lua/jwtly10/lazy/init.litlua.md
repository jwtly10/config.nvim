<!-- @pragma output:init.lua -->
<!-- @pragma force:true -->


# Init

On init, I load a bunch of plugins that I don't require configuration for, many
of these are just dependencies for other plugins. 


```lua
return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },
    'tpope/vim-fugitive',
    'nvim-tree/nvim-web-devicons',
    'github/copilot.vim',

    'preservim/vimux', -- For vim-test, and spawn test run in tmux pane

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function(filetype, option)
                return option == "commentstring"
                    and require("ts_context_commentstring.internal").calculate_commentstring()
                    or get_option(filetype, option)
            end
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        "antosha417/nvim-lsp-file-operations",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },

}
```

