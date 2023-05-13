local branch = {
    'branch',
    icon = ''
}

local function get_winbar()
    local navic = require "nvim-navic"
    if navic.is_available() then
        return navic.get_location()
    else
        return ""
    end
end

local disable_extension = {
    sections = { lualine_a = {} }, filetypes = { 'no-neck-pain' }
}

return {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies =
    { 'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require("lualine").setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '|', right = '  ' },
                section_separators = { left = '  ', right = '  ' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'diff', 'diagnostics' },
                lualine_c = { branch, "vim.fn.expand('%:p')" },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = {},
                lualine_z = { 'progress' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = { 'branch' },
                lualine_c = {},
                lualine_x = { 'fileformat' },
                lualine_y = { 'location' },
                lualine_z = {}
            },
            tabline = {},
            winbar = {
                lualine_a = { 'filetype' },
                lualine_b = {},
                lualine_c = { get_winbar },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_winbar = {},
            extensions = { disable_extension },
        }
    end
}
