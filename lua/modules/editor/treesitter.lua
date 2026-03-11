return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash", "go", "gomod", "gowork", "gosum", "html", "javascript",
            "json", "lua", "make", "markdown", "markdown_inline", "python",
            "regex", "rust", "tsx", "toml", "typescript", "vim", "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = false },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end
}
