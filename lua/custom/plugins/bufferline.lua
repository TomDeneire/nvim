local colors = { bg = "#393836", fg = "#a7adba" }

return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup {
            options = {
                style_preset = bufferline.style_preset.no_italic,
                -- mode = "tabs", -- set to "tabs" to only show tabpages instead
                numbers = "none",
                --	    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
                --	    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
                --	    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
                --	    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
                indicator = {
                    -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    style = 'none',
                },
                buffer_close_icon = '',
                modified_icon = '●',
                close_icon = '',
                left_trunc_marker = '',
                right_trunc_marker = '',
                --- name_formatter can be used to change the buffer's label in the bufferline.
                --- Please note some names can/will break the
                --- bufferline so use this at your discretion knowing that it has
                --- some limitations that will *NOT* be fixed.
                --	    name_formatter = function(buf)  -- buf contains:
                --		  -- name                | str        | the basename of the active file
                --		  -- path                | str        | the full path of the active file
                --		  -- bufnr (buffer only) | int        | the number of the active buffer
                --		  -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
                --		  -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
                --	    end,
                max_name_length = 18,
                max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                truncate_names = false, -- whether or not tab names should be truncated
                tab_size = 18,
                custom_areas = {
                    left = function()
                        return {
                            { text = "    " },
                        }
                    end
                },
                diagnostics = false,
                --	    diagnostics_update_in_insert = false,
                -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
                --	    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                --		return "("..count..")"
                --	    end,
                --	    -- NOTE: this will be called a lot so don't do any heavy processing here
                --	    custom_filter = function(buf_number, buf_numbers)
                --		-- filter out filetypes you don't want to see
                --		if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                --		    return true
                --		end
                --		-- filter out by buffer name
                --		if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                --		    return true
                --		end
                --		-- filter out based on arbitrary rules
                --		-- e.g. filter out vim wiki buffer from tabline in your work repo
                --		if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                --		    return true
                --		end
                --		-- filter out by it's index number in list (don't show first buffer)
                --		if buf_numbers[1] ~= buf_number then
                --		    return true
                --		end
                --	    end,
                --	    offsets = {
                --		{
                --		    filetype = "NvimTree",
                --		    text = "File Explorer" | function ,
                --		    text_align = "left" | "center" | "right"
                --		    separator = true
                --		}
                --	    },
                color_icons = true,       -- whether or not to add the filetype icon highlights
                show_buffer_icons = true, -- disable filetype icons for buffers
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = false,
                --	    show_duplicate_prefix = true | false, -- whether to show duplicate buffer prefix
                --	    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                --	    -- can also be a table containing 2 custom separators
                --	    -- [focused and unfocused]. eg: { '|', '|' }
                --	    separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
                separator_style = "thin",
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                --	    hover = {
                --		enabled = true,
                --		delay = 200,
                --		reveal = {'close'}
                --	    },
                --	    sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
                --		-- add custom logic
                --		return buffer_a.modified > buffer_b.modified
                --	    end
            },
            highlights = {
                fill = {
                    bg = colors.bg,
                },
                background = {
                    bg = colors.bg,
                },
                tab = {
                    bg = colors.bg,
                },
                tab_close = {
                    bg = colors.bg,
                },
                tab_selected = {
                    bg = colors.bg,
                },
                tab_separator = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                tab_separator_selected = {
                    fg = colors.bg,
                    bg = colors.bg,
                    sp = colors.fg,
                },
                close_button = {
                    bg = colors.bg,
                    fg = colors.fg,
                },
                close_button_visible = {
                    bg = colors.bg,
                    fg = colors.fg,
                },
                close_button_selected = {
                    bg = colors.bg,
                    fg = colors.fg,
                },
                buffer_visible = {
                    bg = colors.bg,
                },
                buffer_selected = {
                    bg = colors.bg,
                },
                numbers = {
                    bg = colors.bg,
                },
                numbers_visible = {
                    bg = colors.bg,
                },
                numbers_selected = {
                    bg = colors.bg,
                },
                hint = {
                    bg = colors.bg,
                },
                error = {
                    bg = colors.bg,
                },
                warning = {
                    bg = colors.bg,
                },
                diagnostic = {
                    bg = colors.bg,
                },
                info = {
                    bg = colors.bg,
                },
                modified = {
                    bg = colors.bg,
                },
                modified_visible = {
                    bg = colors.bg,
                },
                modified_selected = {
                    bg = colors.bg,
                },
                duplicate = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                duplicate_visible = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                separator = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                separator_selected = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                separator_visible = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                offset_separator = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                duplicate_selected = {
                    fg = "",
                    bg = colors.bg,
                    italic = true,
                },
                indicator_visible = {
                    fg = "",
                    bg = colors.bg,
                },
                indicator_selected = {
                    fg = "",
                    bg = colors.bg,
                },
                pick_selected = {
                    fg = "",
                    bg = colors.bg,
                    bold = true,
                    italic = true,
                },
                pick_visible = {
                    fg = "",
                    bg = colors.bg,
                    bold = true,
                    italic = true,
                },
                pick = {
                    fg = "",
                    bg = colors.bg,
                    bold = true,
                    italic = true,
                },
            },
        }
    end
}
