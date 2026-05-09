return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash", "go", "gomod", "gowork", "gosum", "html", "javascript",
            "json", "lua", "make", "markdown", "markdown_inline", "python",
            "razor", "regex", "rust", "tsx", "toml", "typescript", "vim",
            "yaml",
        },
        auto_install = false,
    },
    config = function(_, opts)
        vim.filetype.add({
            extension = {
                razor = "razor",
                cshtml = "razor",
            },
        })

        require('nvim-treesitter').setup(opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function(ev)
                pcall(vim.treesitter.start, ev.buf)
            end,
        })
    end,
}
