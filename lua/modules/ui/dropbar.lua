return {
    'Bekaboo/dropbar.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("dropbar").setup({
            opts = { sources = { 'lsp', 'markdown', 'treesitter', 'terminal' } },
        })
    end
}
