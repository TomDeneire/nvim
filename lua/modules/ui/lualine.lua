local function mode_fmt(mode)
    local icons = {
        NORMAL = "󰆾",
        INSERT = "",
        COMMAND = "",
        SELECT = "󰩬",
        VISUAL = "",
        ["V-LINE"] = "",
        TERMINAL = "",
    }
    return (icons[mode] or "") .. " " .. mode
end

local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_idx = 1

local function lsp_spinner()
    if vim.lsp.status() ~= "" then
        spinner_idx = (spinner_idx % #spinner_frames) + 1
        return spinner_frames[spinner_idx] .. " Initializing LSP..."
    end
    return ""
end

return {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        vim.api.nvim_set_hl(0, 'LualineBufferActive', { fg = '#fabd2f', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'LualineBufferInactive', { link = 'Normal' })

        require("lualine").setup {
            options = {
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                always_divide_middle = false,
            },
            tabline = {
                lualine_a = {
                    { function() return '    ' end, padding = 0, color = 'Normal' },
                    {
                        'buffers',
                        mode = 0,
                        show_filename_only = true,
                        show_modified_status = true,
                        symbols = {
                            modified = ' ●',
                            alternate_file = '',
                            directory = '',
                        },
                        buffers_color = {
                            active = 'LualineBufferActive',
                            inactive = 'LualineBufferInactive',
                        },
                        fmt = function(name, buf)
                            local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
                            if devicons_ok then
                                local _, icon_hl = devicons.get_icon(buf.file, vim.fn.fnamemodify(buf.file, ':e'))
                                if icon_hl then
                                    local buf_hl = buf.current and 'LualineBufferActive' or 'LualineBufferInactive'
                                    buf.icon = '%#' .. icon_hl .. '#' .. buf.icon .. '%#' .. buf_hl .. '#'
                                end
                            end
                            return name
                        end,
                    },
                },
            },
            sections = {
                lualine_a = { { 'mode', fmt = mode_fmt } },
                lualine_b = {
                    {
                        'diff',
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " "
                        }
                    },
                    'diagnostics',
                },
                lualine_c = { { lsp_spinner }, { 'filename', path = 3, shorting_target = 40 } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end
}
