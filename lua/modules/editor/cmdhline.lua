return {
    'Sam-programs/cmdline-hl.nvim',
    event = 'VimEnter',
    config = true,
    opts = {
        -- custom formatting/highlight for commands
        custom_types = {
            ["lua"] = { icon = " ", icon_hl = "Title", lang = "lua" },
            ["help"] = { icon = "? ", icon_hl = "Title" },
            ["substitute"] = { pat = "%w(.*)", lang = "regex", show_cmd = true },
        },
        input_hl = "Title",
        -- used to highlight the range in the command e.g. '<,>' in '<,>'s
        range_hl = "FloatBorder",
        ghost_text = false,
    }
}
