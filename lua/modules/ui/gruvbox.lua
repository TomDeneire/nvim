return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        Gruvbox = require("gruvbox")
        Gruvbox.setup({
            italic = {
                strings = false,
                emphasis = true,
                comments = false,
                operators = false,
                folds = false,
            },
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            -- colors in ~/.local/share/nvim/lazy/gruvbox.nvim/lua/gruvbox.lua
            overrides = {
                -- Gruvbox
                ErrorMsg = { link = "GruvboxRed" },
                WarningMsg = { link = "GruvboxOrange" },
                Function = { link = "GruvboxYellowBold" },
            },
            dim_inactive = false,
            transparent_mode = true,
        })

        -- Tell nvim to use this colorscheme
        vim.cmd.colorscheme("gruvbox")
    end
}
