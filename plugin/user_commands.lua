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
    local function format_with_client(client_name)
        vim.lsp.buf.format({
            bufnr = current_buf,
            filter = function(client)
                return client.name == client_name
            end
        })
    end

    local current_buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = current_buf })
    if #clients == 1 then
        format_with_client(clients[1].name)
    else
        vim.ui.select(
            clients,
            {
                prompt = "Choose LSP",
                format_item = function(client)
                    return client.name
                end
            },
            function(chosen_client, _)
                format_with_client(chosen_client.name)
            end
        )
    end
end, {})
