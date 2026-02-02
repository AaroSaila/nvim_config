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
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    {
        "neovim/nvim-lspconfig",
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
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
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
    },
    "m4xshen/autoclose.nvim",
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
        }
    },
    {
        "stevearc/conform.nvim",
        opts = {},
    },
    {
        "stevearc/dressing.nvim",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
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
        "tamton-aquib/staline.nvim"
    },
    {
        "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000
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
        "EdenEast/nightfox.nvim"
    },
    {
        "sphamba/smear-cursor.nvim"
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "elkowar/yuck.vim"
    }
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

require("autoclose").setup({
    keys = {
        ["'"] = { close = false }
    }
})
require("conform").setup({
    formatters_by_ft = {
        -- python = { "black", "isort" }
    }
})
require("dressing").setup()
require("nvim-navic").setup({
    lsp = {
        auto_attach = true
    }
})
require("barbecue").setup()
require("staline").setup()
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
require("image").setup({
    processor = "magick_cli"
})
require("nvim-ts-autotag").setup()

-- Treesitter
require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true
    }
}
require("smear_cursor").setup({
    opts = {                                  -- Default  Range
        stiffness = 0.8,                      -- 0.6      [0, 1]
        trailing_stiffness = 0.6,             -- 0.45     [0, 1]
        stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
        trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
        damping = 0.95,                       -- 0.85     [0, 1]
        damping_insert_mode = 0.95,           -- 0.9      [0, 1]
        distance_stop_animating = 0.5,        -- 0.1      > 0
    },
})

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
    "rust-analyzer",
    "pyright",
    "gopls",
    -- "biome",
    -- "denols"
    "ts_ls"
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

vim.lsp.config("clangd", {
    -- cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-g*:/home/aaro/.espressif/tools/xtensa-esp32s3-elf/esp-12.2.0_20230208/xtensa-esp32s3-elf/bin/*" }
    cmd = { "clangd", "--query-driver=/home/aaro/.espressif/tools/riscv32-esp-elf/esp-14.2.0_20241119/riscv32-esp-elf/bin/*,/home/aaro/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/*" }
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
