vim.api.nvim_create_autocmd({"BufWritePost"}, {
  callback = function()
    require("lint").try_lint()
    vim.cmd(":LspRestart <CR>")
  end
})
