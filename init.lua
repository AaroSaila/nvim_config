-- Leader

vim.g.mapleader = " "

-- Lazy Plugin Manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },
    {
        "williamboman/mason.nvim",
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            { "neovim/nvim-lspconfig" },
        },
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "hrsh7th/cmp-buffer",
    },
    {
        "hrsh7th/cmp-path",
    },
    {
        "hrsh7th/cmp-cmdline",
    },
    {
        "hrsh7th/nvim-cmp",
    },
    {
        "L3MON4D3/LuaSnip",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    -- {
    --     "m4xshen/autoclose.nvim",
    -- },
    {
        "stevearc/conform.nvim",
        opts = {},
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            -- dashboard = { enabled = true },
            explorer = { enabled = true, replace_netrw = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            -- notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            -- scroll = { enabled = true },
            -- statuscolumn = { enabled = true },
            words = { enabled = true },
            lazygit = { enabled = true, configure = true },
        },
    },
    {
        "mfussenegger/nvim-lint"
    },
    {
        "SmiteshP/nvim-navic"
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim", build = "make"
    },
    {
        'brenoprata10/nvim-highlight-colors'
    },
    {
        "windwp/nvim-ts-autotag"
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

    -- Color schemes
    {
        "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
    },
}


-- Setups

require("lazy").setup(plugins)
require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require("cmp")
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
    }),
    sources = cmp.config.sources({
        {
            name = "path",
            option = {
                pathMappings = {
                    ["@"] = "${folder}/src",
                    -- ["/"] = "${folder}/src/public/",
                    -- ["~@"] = "${folder}/src",
                    -- ["/images"] = "${folder}/src/images",
                    -- ["/components"] = "${folder}/src/components",
                }
            }
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "pyright" },
        { name = "clangd" },
        { name = "eslint" },
        { name = "ts_ls" },
        { name = "jdtls" },
        { name = "gopls" },
        { name = "buffer" },
    }),
    formatting = {
        format = require("nvim-highlight-colors").format
    }
})

require("conform").setup({
    formatters_by_ft = {
        -- python = { "black", "isort" }
        json = { "prettier" }
    }
})
require("nvim-navic").setup({
    lsp = {
        auto_attach = true
    }
})
require("barbecue").setup()
require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules/",
            "build",
            ".git/"
        }
    }
})
require("nvim-highlight-colors").setup({})
-- require("image").setup({
--     processor = "magick_cli"
-- })
require("nvim-ts-autotag").setup()

-- Linter setup
local cpplint = require("lint").linters.cpplint
cpplint.args = {
    "--filter=-legal"
}

require("lint").linters_by_ft = {
}


-- LSP setups
vim.lsp.enable({
    "lua_ls",
    "clangd",
    "pyright",
    "gopls",
    "ts_ls",
    "glsl_analyzer"
})

vim.lsp.config("*", {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true
            }
        }
    }
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "Snacks" }
            }
        }
    }
})

vim.lsp.config("clangd", {
    -- cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-g*:/home/aaro/.espressif/tools/xtensa-esp32s3-elf/esp-12.2.0_20230208/xtensa-esp32s3-elf/bin/*" }
    cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-g*,/home/aaro/.espressif/tools/riscv32-esp-elf/esp-14.2.0_20241119/riscv32-esp-elf/bin/*,/home/aaro/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/*" }
})

-- vim.lsp.config("denols", {
--     settings = {
--         deno = {
--             inlayHints = {
--                 parameterTypes = {
--                     enabled = true
--                 },
--                 propertyDeclarationTypes = {
--                     enabled = true
--                 },
--                 variableTypes = {
--                     enabled = true
--                 }
--             }
--         }
--     }
-- })
