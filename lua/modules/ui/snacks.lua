return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        indent = {
            enabled = true,
            char = "│",
            scope = {
                enabled = true,
                highlight = "Normal",
                hl = "Comment",
            },
            animate = {
                enabled = false,
            },
        },
        lazygit = {
            enabled = true,
        },
        picker = {
            enabled = true,
            follow = true,
            layout = {
                preset = "telescope",
            }
        },
    },
}
