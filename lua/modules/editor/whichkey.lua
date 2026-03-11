return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        delay = 400,
        plugins = {
            marks = true,
            registers = false,
            spelling = { enabled = true, suggestions = 20 },
        },
        icons = {
            group = "+",
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
