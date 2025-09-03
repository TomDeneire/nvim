return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
        require('render-markdown').setup({
            bullet = {
                -- Useful context to have when evaluating values.
                -- | level | how deeply nested the list is, 1-indexed          |
                -- | index | how far down the item is at that level, 1-indexed |
                -- | value | text value of the marker node                     |

                -- Turn on / off list bullet rendering
                enabled = true,
                -- Additional modes to render list bullets
                render_modes = false,
                -- Replaces '-'|'+'|'*' of 'list_item'.
                -- If the item is a 'checkbox' a conceal is used to hide the bullet instead.
                -- Output is evaluated depending on the type.
                -- | function   | `value(context)`                                    |
                -- | string     | `value`                                             |
                -- | string[]   | `cycle(value, context.level)`                       |
                -- | string[][] | `clamp(cycle(value, context.level), context.index)` |
                icons = { '●', '○', '◆', '◇' },
                -- Replaces 'n.'|'n)' of 'list_item'.
                -- Output is evaluated using the same logic as 'icons'.
                ordered_icons = function(ctx)
                    local value = vim.trim(ctx.value)
                    local index = tonumber(value:sub(1, #value - 1))
                    return ('%d.'):format(index > 1 and index or ctx.index)
                end,
                -- Padding to add to the left of bullet point.
                -- Output is evaluated depending on the type.
                -- | function | `value(context)` |
                -- | integer  | `value`          |
                left_pad = 0,
                -- Padding to add to the right of bullet point.
                -- Output is evaluated using the same logic as 'left_pad'.
                right_pad = 0,
                -- Highlight for the bullet icon.
                -- Output is evaluated using the same logic as 'icons'.
                highlight = 'RenderMarkdownBullet',
                -- Highlight for item associated with the bullet point.
                -- Output is evaluated using the same logic as 'icons'.
                scope_highlight = {},
            },
            indent = {
                -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
                -- level of the heading. Indenting starts from level 2 headings onward by default.

                -- Turn on / off org-indent-mode.
                enabled = true,
                -- Additional modes to render indents.
                render_modes = false,
                -- Amount of additional padding added for each heading level.
                per_level = 2,
                -- Heading levels <= this value will not be indented.
                -- Use 0 to begin indenting from the very first level.
                skip_level = 1,
                -- Do not indent heading titles, only the body.
                skip_heading = false,
                -- Prefix added when indenting, one per level.
                icon = '▎',
                -- Priority to assign to extmarks.
                priority = 0,
                -- Applied to icon.
                highlight = 'RenderMarkdownIndent',
            },
            heading = {
                -- Turn on / off heading icon & background rendering
                enabled = true,
                -- Turn on / off any sign column related rendering
                sign = true,
                -- Determines how icons fill the available space:
                --  right:   '#'s are concealed and icon is appended to right side
                --  inline:  '#'s are concealed and icon is inlined on left side
                --  overlay: icon is left padded with spaces and inserted on left hiding any additional '#'
                position = 'overlay',
                -- Replaces '#+' of 'atx_h._marker'
                -- The number of '#' in the heading determines the 'level'
                -- The 'level' is used to index into the list using a cycle
                icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
                -- Added to the sign column if enabled
                -- The 'level' is used to index into the list using a cycle
                signs = { '󰫎 ' },
                -- Width of the heading background:
                --  block: width of the heading text
                --  full:  full width of the window
                -- Can also be a list of the above values in which case the 'level' is used
                -- to index into the list using a clamp
                width = 'block',
                -- Amount of margin to add to the left of headings
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                -- Margin available space is computed after accounting for padding
                -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
                left_margin = 0,
                -- Amount of padding to add to the left of headings
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
                left_pad = 0,
                -- Amount of padding to add to the right of headings when width is 'block'
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
                right_pad = 0,
                -- Minimum width to use for headings when width is 'block'
                -- Can also be a list of integers in which case the 'level' is used to index into the list using a clamp
                min_width = 0,
                -- Determines if a border is added above and below headings
                -- Can also be a list of booleans in which case the 'level' is used to index into the list using a clamp
                border = false,
                -- Always use virtual lines for heading borders instead of attempting to use empty lines
                border_virtual = false,
                -- Highlight the start of the border using the foreground highlight
                border_prefix = false,
                -- Used above heading for border
                above = '▄',
                -- Used below heading for border
                below = '▀',
                -- The 'level' is used to index into the list using a clamp
                -- Highlight for the heading icon and extends through the entire line
                backgrounds = {
                    'RenderMarkdownH1Bg',
                    'RenderMarkdownH2Bg',
                    'RenderMarkdownH3Bg',
                    'RenderMarkdownH4Bg',
                    'RenderMarkdownH5Bg',
                    'RenderMarkdownH6Bg',
                },
                -- The 'level' is used to index into the list using a clamp
                -- Highlight for the heading and sign icons
                foregrounds = {
                    'RenderMarkdownH1',
                    'RenderMarkdownH2',
                    'RenderMarkdownH3',
                    'RenderMarkdownH4',
                    'RenderMarkdownH5',
                    'RenderMarkdownH6',
                },
            },
        })
    end
}
