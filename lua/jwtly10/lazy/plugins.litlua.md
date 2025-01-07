<!-- @pragma output:plugins.lua -->
<!-- @pragma force:true-->

# Plugins

These are all the plugins that I use for day to day development

Table of Contents
=================

   * [Plugins](#plugins)
      * [Fzf](#fzf)
      * [Harpoon](#harpoon)
      * [Lualine](#lualine)
      * [Nvim-Tree](#nvim-tree)
      * [vim-test](#vim-test)
      * [Tmux](#tmux)
      * [Treesitter](#treesitter)
      * [Null-ls](#null-ls)
      * [LSP](#lsp)

### Fzf

> Note that `brew install fd` is a requirement for some of the search opts to actually work

I have found that [fzf-lua](https://github.com/ibhagwan/fzf-lua) is much faster in larger projects
than Telescope, so this is my default for now

```lua
return {{
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require('fzf-lua')
        require('fzf-lua').setup({
            keymap = {
                builtin = {
                    ["<C-\\>"] = "toggle-preview"
                }
            },
            previewers = {
                bat = {
                    theme = "Nord",
                }
            },
            'max-perf',
            winopts = {
                backdrop = 100,
                preview = {
                    layout = "vertical",
                },
            },
            files = {
                -- Exclude common build/cache directories and files but still show hidden files
                fd_opts = "--color=never --type f --hidden --no-ignore " ..
                    "--exclude .git --exclude node_modules --exclude .venv " ..
                    "--exclude venv --exclude target --exclude dist --exclude build " ..
                    "--exclude .idea --exclude .settings --exclude .project " ..
                    "--exclude .classpath --exclude __pycache__ --exclude .git " ..
                    "--exclude .idea --exclude '*.pyc' --exclude '*.pyo' " ..
                    "--exclude '*.class' --exclude '*.jar' --exclude '*.war' " ..
                    "--exclude '.gradle' --exclude '.maven' --exclude '.npm' " ..
                    "--exclude '.next' --exclude '.nuxt' --exclude 'coverage' " ..
                    "--exclude '.coverage' --exclude '.pytest_cache' " ..
                    "--exclude '.mypy_cache' --exclude '*.egg-info' " ..
                    "--exclude '*DS_Store' --exclude '.ruff_cache'",
            },
            grep = {
                rg_opts = "--color=never --hidden --no-ignore "
                    .. "--glob '!.git/' "
                    .. "--glob '!node_modules/' "
                    .. "--glob '!{.venv,venv}/' "
                    .. "--glob '!{target,dist,build}/' "
                    .. "--glob '!.idea/' "
                    .. "--glob '!.settings/' "
                    .. "--glob '!{.project,.classpath}' "
                    .. "--glob '!**/__pycache__/' "
                    .. "--glob '!*.{pyc,pyo,class,jar,war}' "
                    .. "--glob '!.{gradle,maven,npm}/' "
                    .. "--glob '!.{next,nuxt}/' "
                    .. "--glob '!coverage/' "
                    .. "--glob '!.coverage' "
                    .. "--glob '!.{pytest,mypy}_cache/' "
                    .. "--glob '!*.egg-info/' "
                    .. "--glob '!.DS_Store' "
                    .. "--glob '!site/'",
            }
        })

        vim.keymap.set("n", "<leader>ps", function()
            fzf.grep_project({
                rg_opts = "--line-number --color=never --hidden --no-ignore --ignore-case "
                    .. "--glob '!.git/' "
                    .. "--glob '!node_modules/' "
                    .. "--glob '!{.venv,venv}/' "
                    .. "--glob '!{target,dist,build}/' "
                    .. "--glob '!.idea/' "
                    .. "--glob '!.settings/' "
                    .. "--glob '!{.project,.classpath}' "
                    .. "--glob '!**/__pycache__/' "
                    .. "--glob '!*.{pyc,pyo,class,jar,war}' "
                    .. "--glob '!.{gradle,maven,npm}/' "
                    .. "--glob '!.{next,nuxt}/' "
                    .. "--glob '!coverage/' "
                    .. "--glob '!.coverage' "
                    .. "--glob '!.{pytest,mypy}_cache/' "
                    .. "--glob '!*.egg-info/' "
                    .. "--glob '!.DS_Store' "
                    .. "--glob '!site/'"
            })
        end)

        vim.keymap.set("n", "<leader>pf", function()
            fzf.files()
        end)

        vim.keymap.set('n', '<leader>o', function()
            fzf.buffers()
        end, { desc = 'Fuzzy find buffers' })

        vim.keymap.set('n', '<leader>ph', function()
            fzf.commands()
        end, { desc = '[?] Help tags' })

        vim.keymap.set('n', '<leader>xx', function()
            fzf.diagnostics_workspace()
        end, { desc = '[?] Diagnostics in workspace' })
    end
},
```
### Harpoon

[Harpoon](https://github.com/ThePrimeagen/harpoon) is a project navigation plugin 
that I use to mainly navigate between files that I am currently working with quickly


```lua
{
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")


        vim.keymap.set("n", "<C-e>", mark.add_file)
        vim.keymap.set("n", "<leader>a", ui.toggle_quick_menu)

        vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Navigate to file in harpoon mark 1" })
        vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Navigate to file in harpoon mark 2" })
        vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Navigate to file in harpoon mark 3" })
        vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Navigate to file in harpoon mark 4" })
        vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, { desc = "Navigate to file in harpoon mark 5" })
        vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end, { desc = "Navigate to file in harpoon mark 6" })
    end
},
```


### Lualine

[Lualine](https://github.com/nvim-lualine/lualine.nvim) is a statusline plugin 
that I use to show a nicer vim status bar

```lua
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto'
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                    }
                }
            }
        })
    end
},
```


### Nvim-Tree

[Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua') is a file explorer plugin
which I use to see a tree view of my project

```lua
{
    'nvim-tree/nvim-tree.lua',
    config = function()
        require("nvim-tree").setup({
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            filters = {
                dotfiles = false,
                git_ignored = false,
            },
            update_focused_file = {
                enable = true,
                update_cwd = false,
            },
        })
        vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeFocus)
        vim.keymap.set("n", "<leader>pn", vim.cmd.NvimTreeToggle)
    end
},
```


### vim-test

[vim-test](https://vim-test/vim-test) is a plugin that I use to run tests in my projects.

I prefer this over nvim-test as its always worked, and I have never seen a reason to switch

```lua
{
    "vim-test/vim-test",
    config = function()
        vim.g['test#strategy'] = 'vimux'

        vim.g['test#python#runner'] = 'pytest'
        vim.g['test#python#pytest#options'] = '-s'

        -- vim.g['test#java#runner'] = 'maventest'

        vim.g['test#rust#runner'] = 'cargotest'
        vim.g['test#rust#cargotest#options'] = '-- --nocapture'

        vim.g['test#neovim#term_position'] = 'botright'
        vim.g['test#neovim#term_height'] = 15

        vim.g['test#go#gotest#options'] = '-v' -- Enable verbose output for Go tests

        -- Run nearest test
        vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>',
            { noremap = true, silent = true })

        -- Run test file
        vim.api.nvim_set_keymap('n', '<leader>tc', ':TestFile<CR>',
            { noremap = true, silent = true })

        -- Run last test
        vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>',
            { noremap = true, silent = true })

        -- Run all tests
        vim.api.nvim_set_keymap('n', '<leader>ta', ':TestSuite<CR>',
            { noremap = true, silent = true })

        -- Visit the test file that was last run
        vim.api.nvim_set_keymap('n', '<leader>tv', ':TestVisit<CR>',
            { noremap = true, silent = true })
    end
},
```


### Tmux

[Tmux](https://github.com/aserowy/tmux.nvim) is a plugin that I use to interact with tmux from neovim

It allows me to keep all the keybindings that I am used to in tmux within neovim, 
essentially making tmux windows feel like native neovim panes

```lua
{
    "aserowy/tmux.nvim",
    config = function()
        return require("tmux").setup({
            copy_sync = {
                enable = false,
                sync_clipboard = false,
            },
        })
    end,
},
```


### Treesitter

[Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) needs no
introduction :)


```lua
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "markdown", "markdown_inline", "java", "typescript", "vue", "tsx", "html", "python", "javascript", "c", "lua", "vim", "vimdoc", "query" },
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            },
            indent = {
                enable = true,
                disable = { "py" },
            },
        }
    end
},
```


### Null-ls

[Null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) is a plugin that 
I use to handle all my formatting. It's archived now, but it still works
and until it no longer supports the latest neovim version, I wont move away.

```lua
{
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        local null_ls_status_ok, null_ls = pcall(require, "null-ls")
        if not null_ls_status_ok then
            return
        end

        vim.g.format_on_save = true -- Enabled by default

        local formatting = null_ls.builtins.formatting
        local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })

        local function toggle_format_on_save()
            vim.g.format_on_save = not vim.g.format_on_save
            print("Format on save: " .. (vim.g.format_on_save and "enabled" or "disabled"))
        end

        vim.api.nvim_create_user_command('ToggleAutoFormat', function()
            vim.g.format_on_save = not vim.g.format_on_save
            print("Format on save: " .. (vim.g.format_on_save and "enabled" or "disabled"))
        end, {})

        vim.keymap.set("n", "<leader>mff", toggle_format_on_save, { desc = "Toggle format on save" })


        null_ls.setup {
            debug = false,
            sources = {
                formatting.goimports,
                formatting.prettier.with {
                    filetypes = {
                        "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "html", "json",
                        "yaml", "graphql" },
                    prefer_local = "node_modules/.bin",
                },
                formatting.stylua.with {
                    filetypes = { 'lua' },
                    extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/.stylua.toml") }
                },
                formatting.rustfmt.with {
                    filetypes = { 'rust' },
                    extra_args = { "--emit=stdout" },
                    args = { "--emit=stdout" },
                },
                formatting.xmlformat.with {
                    filetypes = { 'xml', 'html', 'xhtml' },
                    extra_args = { "--indent-size=4" },
                },
                formatting.ruff,
                formatting.clang_format.with {
                    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
                },
            },

            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

                    -- FOrmat on save if toggled
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = group,
                        buffer = bufnr,
                        callback = function()
                            if vim.g.format_on_save then
                                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                            end
                        end,
                    })

                    vim.keymap.set("n", "<leader>mf", function()
                        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                    end, { buffer = bufnr, desc = "Lsp [fo]rmat" })
                end

                if client.supports_method("textDocument/rangeFormatting") then
                    vim.keymap.set("n", "<leader>mf", function()
                        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                    end, { buffer = bufnr, desc = "[lsp] format" })
                end
            end,
        }
    end
},

```


### LSP

This is my LSP setup for the languages that I use most.

```lua
{
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")

        -- Set global defaults for all servers
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities(),
            require 'lsp-file-operations'.default_capabilities()
        )


        vim.api.nvim_create_autocmd('BufRead', {
            pattern = '*.litlua.md',
            callback = function()
                vim.lsp.start({
                    name = 'litlua',
                    cmd = { 'litlua-ls'},
                    root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
                })
            end,
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                require 'lspconfig'.html.setup {
                    capabilities = capabilities,
                },
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup {
                        capabilities = capabilities,
                        cmd = {
                            "clangd",
                            "--enable-config",
                            "--query-driver=/usr/bin/clang++"
                        },
                    }
                end,

                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.gopls.setup {
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                buildFlags = { "-tags=integration" }
                            }
                        }
                    }
                end,

                ["rust_analyzer"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.rust_analyzer.setup({
                        settings = {
                            ["rust-analyzer"] = {
                                checkOnSave = {
                                    command = "clippy"
                                },
                                PATH = "append"
                            },
                        },
                        on_attach = format,
                    })
                end,

                ["zls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup {
                        capabilities = capabilities,
                        settings = {
                            zls = {
                                autoformat = false,
                            }
                        }
                    }
                    vim.g.zig_fmt_autosave = 0
                end,
            }

        })

        cmp.setup {
            completion = {
                completeopt = "menu,menuone, noinsert",
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = entry:get_completion_item().detail
                    vim_item.depracted = false
                    return vim_item
                end
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "nvim_lua" },
                { name = "path" },
                { name = "ultisnips" },

            },
        }
    end
}
```



Ignore: Closing tag
```lua
}
```

