vim.cmd("colorscheme moonfly")
vim.cmd("set nu")
vim.cmd("set rnu")
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")  -- Sets shift width
vim.cmd("set softtabstop=2") -- Do not change!
vim.cmd("set tabstop=2")
vim.cmd("set nowrap")
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
vim.opt.scrolloff = 8
vim.opt.termguicolors = true

vim.diagnostic.config({
  virtual_lines = true
})
