vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<Leader>ff", require("conform").format, { desc = "Format (Formatter)" })
vim.keymap.set("n", "<Leader>w", vim.cmd.write, { desc = "Write" })
vim.keymap.set("n", "<Leader>n", Snacks.explorer.open, { desc = "File Explorer" })
vim.cmd("nnoremap <silent> <Leader>h :noh<CR>")
vim.keymap.set("n", "<Leader>p", Snacks.lazygit.open, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>m", function() vim.cmd("vertical botright Man") end, { desc = "Man" })
vim.keymap.set("n", "<Leader>s", vim.treesitter.start, { desc = "treesitter start" })

-- Surrounds
vim.keymap.set("n", "<Leader>{", "i{<ESC>ea}<ESC>", { desc = "{}" })
vim.keymap.set("n", "<Leader>\"", "i\"<ESC>ea\"<ESC>", { desc = "\"\"" })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "<Leader>fl", vim.lsp.buf.format, { desc = "Format (LSP)" })
vim.keymap.set("n", "<Leader>fc", vim.cmd.FormatChooseLsp, { desc = "Format (Choose lsp)" })
vim.keymap.set("n", "<Leader>l", vim.cmd.OrganizeImports, { desc = "Organize Imports" })

local function toggle_inlay_hints()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
vim.keymap.set("n", "<Leader>i", toggle_inlay_hints, { desc = "Toggle inlay hints" })
vim.keymap.set("n", "<Leader>g", ":lsp restart<CR>", { desc = "LSP restart" })
vim.keymap.set("n", "<Leader>o", ":lsp stop<CR>", { desc = "LSP stop" })

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<Leader>tf", telescope.find_files, { desc = "Telescope files" })
vim.keymap.set("n", "<Leader>th", telescope.help_tags, { desc = "Telescope help tags" })

-- Window resizing
vim.cmd("nnoremap <silent> <M-v> :vertical :resize -1<CR>")
vim.cmd("nnoremap <silent> <M-b> :vertical :resize +1<CR>")

-- Window navigation
vim.cmd("tnoremap <A-h> <C-\\><C-N><C-w>h")
vim.cmd("tnoremap <A-j> <C-\\><C-N><C-w>j")
vim.cmd("tnoremap <A-k> <C-\\><C-N><C-w>k")
vim.cmd("tnoremap <A-l> <C-\\><C-N><C-w>l")
vim.cmd("inoremap <A-h> <C-\\><C-N><C-w>h")
vim.cmd("inoremap <A-j> <C-\\><C-N><C-w>j")
vim.cmd("inoremap <A-k> <C-\\><C-N><C-w>k")
vim.cmd("inoremap <A-l> <C-\\><C-N><C-w>l")
vim.cmd("nnoremap <A-h> <C-w>h")
vim.cmd("nnoremap <A-j> <C-w>j")
vim.cmd("nnoremap <A-k> <C-w>k")
vim.cmd("nnoremap <A-l> <C-w>l")


-- Tab navigation
vim.keymap.set("n", "<C-t>", vim.cmd.tabnew)
vim.keymap.set("n", "<A-m>", "gt")
vim.keymap.set("n", "<A-n>", "gT")

vim.keymap.set("n", "<Leader>en", "oif err != nil {\n}<ESC>ko")

-- command-line navigation
vim.cmd(":cnoremap <C-A> <Home>")
vim.cmd(":cnoremap <C-B> <Left>")
vim.cmd(":cnoremap <C-D> <Del>")
vim.cmd(":cnoremap <C-E> <End>")
vim.cmd(":cnoremap <C-F> <Right>")
vim.cmd(":cnoremap <C-N> <Down>")
vim.cmd(":cnoremap <C-P> <Up>")
vim.cmd(":cnoremap <Esc><C-B> <S-Left>")
vim.cmd(":cnoremap <Esc><C-F> <S-Right>")
