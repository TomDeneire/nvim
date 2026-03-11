local prettier_fts = {
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml",
    "graphql", "handlebars", "markdown",
}

local formatters_by_ft = {
    python = { "ruff_format" },
    rust = { "rustfmt" },
    htmldjango = { "prettier", "djlint" },
    xml = { "xmlformatter" },
}

for _, ft in ipairs(prettier_fts) do
    formatters_by_ft[ft] = { "prettier" }
end

return {
    'stevearc/conform.nvim',
    event = "BufWritePre",
    cmd = { "FormatDisable", "FormatEnable" },
    config = function()
        require("conform").setup({
            formatters_by_ft = formatters_by_ft,
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 1000, lsp_format = 'fallback' }
            end,
        })

        vim.keymap.set("n", "<leader>f", function()
            require('conform').format({ timeout_ms = 100000, lsp_format = 'fallback' })
        end, { desc = "Format with conform" })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, { desc = "Disable autoformat-on-save", bang = true })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, { desc = "Re-enable autoformat-on-save" })
    end
}
