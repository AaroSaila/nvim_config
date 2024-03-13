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
  --	"williamboman/mason.nvim",
  --	"williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
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
    config = function()
      require("nordic").load()
    end,
  },
  --	"mhartington/formatter.nvim",
}

-- "requires" --

require("lazy").setup(plugins)
--require("mason").setup()
--require("mason-lspconfig").setup()
require("lspconfig").lua_ls.setup({})
--require("lspconfig").pyright.setup({})
--[[ require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
	},

}) ]]
      --
