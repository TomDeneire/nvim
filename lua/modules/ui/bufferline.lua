local highlights = {
    buffer_selected = {
        fg = "#fabd2f",
        bold = false,
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
                separator_style = { "" },
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
