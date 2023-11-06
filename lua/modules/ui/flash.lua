return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        highlight =
        {
            backdrop = false },
        label = {
            style = "inline" }, ---@type "eol" | "overlay" | "right_align" | "inline"
        modes = {
            search = { enabled = false },
            char = {
                jump_labels = true,
                highlight = { backdrop = false },
                keys = { "f", "F" },
            }
        }
    },
    -- stylua: ignore
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        {
            "S",
            mode = { "n", "o", "x" },
            function() require("flash").jump({ search = { forward = false }, }) end,
            desc = "Flash reverse"
        },
        -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc =
        -- "Toggle Flash Search" },
    },
}
