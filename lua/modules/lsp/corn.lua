return
{
    'RaafatTurki/corn.nvim',
    config = function()
        require 'corn'.setup {
            -- enables plugin auto commands
            auto_cmds = true,

            -- sorts diagnostics according to a criteria. must be one of `severity`, `severity_reverse`, `column`, `column_reverse`, `line_number` or `line_number_reverse`
            sort_method = 'severity',

            -- sets the scope to be searched for diagnostics, must be one of `line` or `file`
            scope = 'line',

            -- sets the style of the border, must be one of `single`, `double`, `rounded`, `solid`, `shadow` or `none`
            border_style = 'single',
            --
            -- sets which vim modes corn isn't allowed to render in, should contain strings like 'n', 'i', 'v', 'V' .. etc
            blacklisted_modes = { 'i' },

            -- highlights to use for each diagnostic severity level
            highlights = {
                error = "DiagnosticFloatingError",
                warn = "DiagnosticFloatingWarn",
                info = "DiagnosticFloatingInfo",
                hint = "DiagnosticFloatingHint",
            },

            -- icons to use for each diagnostic severity level
            icons = {
                error = "E",
                warn = "W",
                hint = "H",
                info = "I",
            },

            -- a preprocessor function that takes a raw Corn.Item and returns it after modification, could be used for truncation or other purposes
            item_preprocess_func = function(item)
                -- the default truncation logic is here ...
                return item
            end,
            -- a hook that executes each time corn is toggled. the current state is provided via `is_hidden`
            on_toggle = function(is_hidden)
                -- custom logic goes here
            end,
        }
    end
}
