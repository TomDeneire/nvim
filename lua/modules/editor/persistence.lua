return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
        { "<leader>s", function() require('persistence').load() end, desc = "Restore previous session" },
    },
    config = true,
}
