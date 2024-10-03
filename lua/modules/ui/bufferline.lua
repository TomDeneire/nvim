local colors = require("modules.color").colors()

local highlights = {
    fill = {
        bg = colors.statusline_bg,
    },
    background = {
        bg = colors.statusline_bg,
        fg = colors.grey,
    },
    tab = {
        bg = colors.statusline_bg,
        fg = colors.grey,
    },
    tab_close = {
        bg = colors.statusline_bg,
    },
    tab_selected = {
        bg = colors.statusline_bg,
    },
    tab_separator = {
        fg = colors.statusline_bg,
        bg = colors.statusline_bg,
    },
    tab_separator_selected = {
        fg = colors.statusline_bg,
        bg = colors.statusline_bg,
        sp = colors.grey,
    },
    close_button = {
        bg = colors.statusline_bg,
        fg = colors.grey,
    },
    close_button_visible = {
        bg = colors.statusline_bg,
        fg = colors.grey,
    },
    close_button_selected = {
        bg = colors.statusline_bg,
        fg = colors.grey,
    },
    buffer_visible = {
        bg = colors.statusline_bg,
    },
    buffer_selected = {
        bg = colors.statusline_bg,
        fg = colors.green,
        bold = false,
    },
    numbers = {
        bg = colors.statusline_bg,
    },
    numbers_visible = {
        bg = colors.statusline_bg,
    },
    numbers_selected = {
        bg = colors.statusline_bg,
    },
    hint = {
        bg = colors.statusline_bg,
    },
    error = {
        bg = colors.statusline_bg,
    },
    warning = {
        bg = colors.statusline_bg,
    },
    diagnostic = {
        bg = colors.statusline_bg,
    },
    info = {
        bg = colors.statusline_bg,
    },
    modified = {
        bg = colors.statusline_bg,
    },
    modified_visible = {
        bg = colors.statusline_bg,
    },
    modified_selected = {
        bg = colors.statusline_bg,
    },
    duplicate = {
        fg = colors.grey,
        bg = colors.statusline_bg,
    },
    duplicate_visible = {
        fg = colors.grey,
        bg = colors.statusline_bg,
    },
    separator = {
        fg = colors.statusline_bg,
        bg = colors.statusline_bg,
    },
    separator_selected = {
        fg = colors.statusline_bg,
        bg = colors.statusline_bg,
    },
    separator_visible = {
        fg = colors.statusline_bg,
        bg = colors.statusline_bg,
    },
    offset_separator = {
        fg = colors.statusline_bg,
        bg = colors.statusline_bg,
    },
    duplicate_selected = {
        fg = "",
        bg = colors.statusline_bg,
        italic = true,
    },
    indicator_visible = {
        fg = "",
        bg = colors.statusline_bg,
    },
    indicator_selected = {
        fg = "",
        bg = colors.statusline_bg,
    },
    pick_selected = {
        fg = "",
        bg = colors.statusline_bg,
        bold = true,
        italic = true,
    },
    pick_visible = {
        fg = "",
        bg = colors.statusline_bg,
        bold = true,
        italic = true,
    },
    pick = {
        fg = "",
        bg = colors.statusline_bg,
        bold = true,
        italic = true,
    },
}

return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup {
            options = {
                style_preset = bufferline.style_preset.no_italic,
                numbers = "none",
                indicator = {
                    style = 'none',
                },
                truncate_names = false,
                custom_areas = {
                    left = function()
                        return {
                            { text = "    " },
                        }
                    end
                },
                diagnostics = false,
                show_buffer_icons = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = false,
                enforce_regular_tabs = false,
                always_show_bufferline = true,
            },
            highlights = highlights,
        }
    end
}
