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
  "neovim/nvim-lspconfig",
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
}


-- Setups

require("lazy").setup(plugins)
require("mason").setup()
require("mason-lspconfig").setup()
local cmp = require("cmp")
cmp.setup({
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
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "pyright" },
  }, {
    { name = "buffer" },
  })
})
require("autoclose").setup()
require("conform").setup({
  formatters_by_ft = {
    python = { "black", "isort" }
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


-- Linter setup
local cpplint = require("lint").linters.cpplint
cpplint.args = {
  "--filter=-legal"
}

require("lint").linters_by_ft = {
  c = { "cpplint", },
  cpp = { "cpplint", }
}


-- LSP setups

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})
require("lspconfig").pyright.setup({})
require("lspconfig").clangd.setup({})
require("lspconfig").jdtls.setup({})
