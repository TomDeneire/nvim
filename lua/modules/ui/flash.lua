return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        highlight = { backdrop = false },
        modes = {
            search = { enabled = false },
            char = {
                jump_labels = true,
                highlight = { backdrop = false },
                keys = { "f", "F" },
            }
        }
    },
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function() require("flash").jump() end,
            desc = "Flash"
        },
        {
            "S",
            mode = { "n", "o", "x" },
            function() require("flash").jump({ search = { forward = false }, }) end,
            desc = "Flash reverse"
        },
    },
}
