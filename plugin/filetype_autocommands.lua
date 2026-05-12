vim.api.nvim_create_autocmd(
    {
        -- "BufNewFile",
        -- "BufReadPost",
        -- "FileReadPost",
        "BufEnter"
    },
    {
        pattern = { "*.go", "*.sql", "*.sh", "*.c", "*.cpp", "*.build", "*.frag", "*.vert", "*.geom", "*.py", "*.ts", "*.js", "*.tsx", "*.jsx", "*.h", "*.hpp" },
        callback = function(ev)
            vim.treesitter.start(ev.buf)
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'
        end
    }
)
