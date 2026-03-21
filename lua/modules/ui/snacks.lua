PROJECT_DIR = "/home/tdeneire/projects"

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
            },
        },
    },
    keys = {
        {
            "ff",
            function()
                Snacks.picker.git_grep({
                    hidden = true,
                    untracked = true,
                    ignorecase = true,
                })
            end,
            desc = "Git grep"
        },

        {
            "<c-f>",
            function()
                Snacks.picker.grep({
                    ignored = true,
                    hidden = true,
                    cwd = PROJECT_DIR,
                    ignorecase = true,
                })
            end,
            desc = "Project grep"
        },

        {
            "ts",
            function()
                Snacks.picker.git_files({
                    untracked = true,
                })
            end,
            desc = "Git files"
        },

        {
            "<c-p>",
            function()
                Snacks.picker.files({
                    ignored = true,
                    hidden = true,
                    cwd = PROJECT_DIR,
                })
            end,
            desc = "Project files"
        },

        {
            "<leader>old",
            function()
                Snacks.picker.recent({
                    ignored = true,
                    hidden = true,
                })
            end,
            desc = "Find recent files"
        },

        { "tb",         function() Snacks.picker.buffers() end, desc = "Show buffers" },
        { "<leader>lg", function() Snacks.lazygit() end,        desc = "Open LazyGit" },
        { "<leader>u",  function() Snacks.picker.undo() end,    desc = "Undo tree" },
        { "<leader>p",  function() Snacks.picker.pickers() end, desc = "Show pickers" },
    },
}
