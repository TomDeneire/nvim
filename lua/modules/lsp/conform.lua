return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                ["lua"] = { "stylua" },
                ["python"] = { "autopep8" },
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
                ["json"] = { "prettier" },
                ["jsonc"] = { "prettier" },
                ["yaml"] = { "prettier" },
                ["markdown"] = { "prettier" },
                ["markdown.mdx"] = { "prettier" },
                ["graphql"] = { "prettier" },
                ["handlebars"] = { "prettier" },
                ["xml"] = { "xmlformatter" },
                -- -- Conform will run multiple formatters sequentially
                -- python = { "isort", "black" },
                -- -- Use a sub-list to run only the first available formatter
                -- javascript = { { "prettierd", "prettier" } },
            },
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true }
            end,
        })

        -- Commands for disabling/enabling autoformat
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
