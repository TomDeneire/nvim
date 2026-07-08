return {
    'Bekaboo/dropbar.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("dropbar").setup({
            bar = {
                padding = {
                    left = 6, -- Adjust this number to shift it further to the right
                },
            },
        })
        -- nicer background for WinBar
        vim.api.nvim_set_hl(0, "WinBar", { link = "TabLine" })
    end
}
