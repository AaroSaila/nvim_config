vim.cmd("cnoreabbrev vMan vertical botright Man")
vim.cmd("cnoreabbrev vhelp vertical botright help")
vim.cmd("cnoreabbrev todog vimgrep /\\ctodo/")

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })


local function organizeImports()
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source.organizeImports"
      }
    },
    apply = true
  })
end

vim.api.nvim_create_user_command("OrganizeImports", organizeImports, {})

vim.api.nvim_create_user_command(
    "Todogg",
    function()
        vim.cmd("vimgrep /\\ctodo/ ./**/src/**/*.go")
    end,
    {}
)

vim.api.nvim_create_user_command("FormatChooseLsp", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local client_names = {}
    for _, client in pairs(vim.lsp.get_clients({ bufnr = current_buf })) do
        table.insert(client_names, client.name)
    end
    vim.ui.select(client_names, { prompt = "Choose LSP" }, function(chosen_client, _)
        vim.lsp.buf.format({
            bufnr = current_buf,
            filter = function(client)
                return client.name == chosen_client
            end
        })
    end)
end, {})

