return {
    'Sam-programs/cmdline-hl.nvim',
    event = 'VimEnter',
    opts = {
        type_signs = {
            [":"] = { " ", "Title" },
            ["/"] = { " ", "Title" },
            ["?"] = { " ", "Title" },
            ["="] = { " ", "Title" },
        },
        -- custom formatting/highlight for commands
        custom_types = {
            -- ["command-name"] = {
            -- [icon],[icon_hl], default to `:` icon and highlight
            -- [lang], defaults to vim
            -- [showcmd], defaults to false
            -- [pat], defaults to "%w*%s*(.*)"
            -- [code], defaults to nil
            -- }
            -- lang is the treesitter language to use for the commands
            -- showcmd is true if the command should be displayed or to only show the icon
            -- pat is used to extract the part of the command that needs highlighting
            -- the part is matched against the raw command you don't need to worry about ranges
            -- e.g. in '<,>'s/foo/bar/
            -- pat is checked against s/foo/bar
            -- you could also use the 'code' function to extract the part that needs highlighting
            -- ["command-name"]  = false -- to disable a type
            ["lua"] = { icon = " ", icon_hl = "Title", lang = "lua" },
            ["help"] = { icon = "? ", icon_hl = "Title" },
            ["substitute"] = { pat = "%w(.*)", lang = "regex", show_cmd = true },
        },
        input_hl = "Title",
        -- used to highlight the range in the command e.g. '<,>' in '<,>'s
        range_hl = "FloatBorder",
        ghost_text = false,
        -- a function that returns the ghost text to display on the cursor
        -- by default shows ghost text for the next history match, you can complete it by pressing <up>
        -- WARNING: ghost_text_provider isn't called in a safe context use custom ones from plugins like nvim-cmp might result in crashes
        -- calling it in a safe context results in the command-line being really slow to update
        -- ghost_text_provider = require('cmdline-hl').calculate_ghost_text,
        -- highlight used for rendering ghost text
        ghost_text_hl = 'Comment',
        inline_ghost_text = false
    }
}
