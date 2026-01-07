vim.cmd("colorscheme moonfly")
vim.cmd("set nu")
vim.cmd("set rnu")
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=4")  -- Sets shift width
vim.cmd("set softtabstop=2") -- Do not change!
vim.cmd("set tabstop=4")
vim.cmd("set nowrap")
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.signcolumn = "yes:1"

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
})
