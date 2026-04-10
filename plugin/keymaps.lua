vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<Leader>F", vim.cmd.Format, { desc = "Format (Formatter)" })
vim.keymap.set("n", "<Leader>w", vim.cmd.write, { desc = "Write" })
-- vim.keymap.set("i", "jj", "<ESC>")
vim.cmd("nnoremap <silent> <Leader>n :Neotree<CR>")
vim.cmd("nnoremap <silent> <Leader>g :LspRestart<CR>")
vim.cmd("nnoremap <silent> <Leader>o :LspStop<CR>")
vim.cmd("nnoremap <silent> <Leader>h :noh<CR>")

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format, { desc = "Format (LSP)" })
vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "<Leader>l", vim.cmd.OrganizeImports, { desc = "Organize Imports" })

local function toggle_inlay_hints()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
vim.keymap.set("n", "<Leader>i", toggle_inlay_hints, { desc = "Toggle inlay hints" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>t", builtin.find_files, {})

-- Window resizing
vim.cmd("nnoremap <silent> <M-v> :vertical :resize -1<CR>")
vim.cmd("nnoremap <silent> <M-b> :vertical :resize +1<CR>")

-- Window navigation
vim.cmd("tnoremap <silent> <Esc> <C-\\><C-n>")
vim.cmd("tnoremap <silent> <A-h> <C-\\><C-N><C-w>h")
vim.cmd("tnoremap <silent> <A-j> <C-\\><C-N><C-w>j")
vim.cmd("tnoremap <silent> <A-k> <C-\\><C-N><C-w>k")
vim.cmd("tnoremap <silent> <A-l> <C-\\><C-N><C-w>l")
vim.cmd("inoremap <A-h> <C-\\><C-N><C-w>h")
vim.cmd("inoremap <A-j> <C-\\><C-N><C-w>j")
vim.cmd("inoremap <A-k> <C-\\><C-N><C-w>k")
vim.cmd("inoremap <A-l> <C-\\><C-N><C-w>l")
vim.cmd("nnoremap <A-h> <C-w>h")
vim.cmd("nnoremap <A-j> <C-w>j")
vim.cmd("nnoremap <A-k> <C-w>k")
vim.cmd("nnoremap <A-l> <C-w>l")
-- vim.cmd("nnoremap <silent> <C-h> :wincmd h<CR>")
-- vim.cmd("nnoremap <silent> <C-j> :wincmd j<CR>")
-- vim.cmd("nnoremap <silent> <C-k> :wincmd k<CR>")
-- vim.cmd("nnoremap <silent> <C-l> :wincmd l<CR>")

-- Tab navigation
vim.keymap.set("n", "<C-m>", "gt")
vim.keymap.set("n", "<C-n>", "gT")
vim.keymap.set("n", "<C-n>", "gT")

vim.keymap.set("n", "<Leader>st", "istd::")
vim.keymap.set("n", "<Leader>en", "oif err != nil {\n}<ESC>ko")

