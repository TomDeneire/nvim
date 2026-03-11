return {
    'Bekaboo/dropbar.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("dropbar").setup()
        -- nicer background for WinBar
        vim.api.nvim_set_hl(0, "WinBar", { link = "TabLine" })
    end
}
