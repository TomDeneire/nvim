return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup {
            options = {
                style_preset = bufferline.style_preset.no_italic,
                indicator = { style = 'none' },
                separator_style = { "" },
                truncate_names = false,
                custom_areas = {
                    left = function()
                        return { { text = "  " } }
                    end
                },
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = false,
            },
            highlights = {
                buffer_selected = {
                    fg = "#fabd2f",
                },
            },
        }
    end
}
