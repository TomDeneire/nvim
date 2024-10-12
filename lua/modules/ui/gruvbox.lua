return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        Gruvbox = require("gruvbox")
        local colors = Gruvbox.palette
        Gruvbox.setup({
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            -- colors in ~/.local/share/nvim/lazy/gruvbox.nvim/lua/gruvbox.lua
            overrides = {
                -- QtechNG
                MumpsCommand = { italic = true },
                MumpsLabel = { fg = colors.neutral_blue, bold = true },
                MumpsGlobalName = { fg = colors.neutral_blue, bold = true },
                MumpsMacro = { fg = colors.neutral_blue, italic = true },
                MumpsPName = { fg = colors.bright_blue, italic = true },
                MumpsUName = { fg = colors.neutral_aqua, bold = true },
                MumpsCName = { fg = colors.gray },
                MumpsFName = { fg = colors.bright_blue, bold = true },
                MumpsDoGoLabel = { fg = colors.neutral_aqua, italic = true },
                MumpsLabelName = { fg = colors.bright_green, bold = true },
                MumpsIntrinsicFunction = { fg = colors.neutral_aqua, italic = true },
                BfileValue = { fg = colors.light0_hard },
                DfileInstruction = { fg = colors.light0_hard, bold = true },
                DfileMacroLabel = { fg = colors.neutral_blue, bold = true },
                DfileSynopsis = { fg = colors.neutral_purple },
                DfileExample = { fg = colors.neutral_yellow },
                -- Gruvbox
                ErrorMsg = { link = "GruvboxRed" },
                WarningMsg = { link = "GruvboxOrange" },
                Function = { link = "GruvboxYellowBold" },
            },
            dim_inactive = true,
            transparent_mode = true,
        })

        -- Tell nvim to use this colorscheme
        vim.cmd.colorscheme("gruvbox")
    end
}
