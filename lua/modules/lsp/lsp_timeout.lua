return {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    init = function()
        vim.g.lspTimeoutConfig = {
            stopTimeout  = 1000 * 60 * 5, -- ms, timeout before stopping all LSP servers
            startTimeout = 1000 * 10,     -- ms, timeout before restart
            silent       = true           -- true to suppress notifications
        }
    end
}
