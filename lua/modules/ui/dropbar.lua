return {
    'Bekaboo/dropbar.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("dropbar").setup({
            bar = {
                padding = {
                    left = 6,
                },
                -- Control which sources are active global/per-buffer
                sources = function(buf, win)
                    local sources = require("dropbar.sources")

                    -- Fallback logic: check for LSP, then Treesitter, then Markdown
                    -- We intentionally omit sources.path here
                    if vim.bo[buf].ft == "markdown" then
                        return { sources.markdown }
                    end

                    return {
                        sources.lsp,
                        sources.treesitter,
                    }
                end,
            },
        })
        -- nicer background for WinBar
        vim.api.nvim_set_hl(0, "WinBar", { link = "TabLine" })
    end
}
