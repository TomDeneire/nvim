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
        auto_install = true,
    },
    config = function(_, opts)
        vim.filetype.add({
            extension = {
                razor = "razor",
                cshtml = "razor",
            },
        })

        require('nvim-treesitter').setup(opts)
        require('nvim-treesitter').install(opts.ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = opts.ensure_installed,
            callback = function() vim.treesitter.start() end,
        })
    end,
}
