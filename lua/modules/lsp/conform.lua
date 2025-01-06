return {
    'stevearc/conform.nvim',
    opts = {},
    lazy = false,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                ["python"] = { "blue" },
                ["rust"] = { "rustfmt" },
                ["javascript"] = { "prettier" },
                ["javascriptreact"] = { "prettier" },
                ["typescript"] = { "prettier" },
                ["typescriptreact"] = { "prettier" },
                ["vue"] = { "prettier" },
                ["css"] = { "prettier" },
                ["scss"] = { "prettier" },
                ["less"] = { "prettier" },
                ["html"] = { "prettier" },
                ["htmldjango"] = { "prettier", "djlint" },
                ["json"] = { "prettier" },
                ["jsonc"] = { "prettier" },
                ["yaml"] = { "prettier" },
                ["markdown"] = {},
                ["graphql"] = { "prettier" },
                ["handlebars"] = { "prettier" },
                ["xml"] = { "xmlformatter" },
            },
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 1000, lsp_format = 'fallback' }
            end,
        })

        vim.keymap.set("n", "<leader>c",
            ":lua require('conform').format({ timeout_ms = 100000,lsp_format = 'fallback'  })<cr>",
            { desc = "Format with conform with very long timeout" })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end
}
