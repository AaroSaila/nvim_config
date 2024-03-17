vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format, { desc = "Format (LSP)" })
vim.keymap.set("n", "<Leader>F", vim.cmd.Format, { desc = "Format (Formatter)" })
vim.cmd("nnoremap <silent> <Leader>n :Neotree<CR>")

-- Split navigation
vim.cmd("nnoremap <silent> <C-h> :wincmd h<CR>")
vim.cmd("nnoremap <silent> <C-j> :wincmd j<CR>")
vim.cmd("nnoremap <silent> <C-k> :wincmd k<CR>")
vim.cmd("nnoremap <silent> <C-l> :wincmd l<CR>")

-- Tab navigation
vim.keymap.set("n", "<C-m>", "gt")
vim.keymap.set("n", "<C-n>", "gT")
