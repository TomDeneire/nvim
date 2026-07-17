return {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
        require("lint").linters_by_ft = {
            python = { "ruff" },
            go = { "golangcilint" },
            lua = { "selene" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
