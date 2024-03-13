vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format)

-- Split navigation
vim.cmd("nnoremap <silent> <C-h> :wincmd h<CR>")
vim.cmd("nnoremap <silent> <C-j> :wincmd j<CR>")
vim.cmd("nnoremap <silent> <C-k> :wincmd k<CR>")
vim.cmd("nnoremap <silent> <C-l> :wincmd l<CR>")
