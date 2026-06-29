return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        local gruvbox = require("gruvbox")
        gruvbox.setup({
            italic = {
                strings = false,
                emphasis = true,
                comments = false,
                operators = false,
                folds = false,
            },
            contrast = "hard",
            overrides = {
                ErrorMsg                   = { link = "GruvboxRed" },
                WarningMsg                 = { link = "GruvboxOrange" },
                Function                   = { link = "GruvboxYellowBold" },
                Error                      = { link = "GruvboxRed" },

                -- Verwijder de achtergrondkleur voor Git status in Telescope resultaten
                TelescopeResultsDiffChange = { bg = "NONE", link = "GruvboxYellow" },
                TelescopeResultsDiffAdd    = { bg = "NONE", link = "GruvboxGreen" },
                TelescopeResultsDiffDelete = { bg = "NONE", link = "GruvboxRed" },
            },
            transparent_mode = true,
        })

        -- Tell nvim to use this colorscheme
        vim.cmd.colorscheme("gruvbox")
    end
}
