if vim.g.vscode then
    return
end
-- Lualine

require('lualine').setup {
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
        lualine_c = { 'branch',"vim.fn.expand('%:p')" },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = {},
        lualine_z = { 'progress' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'branch'},
        lualine_c = {},
        lualine_x = { 'fileformat' },
        lualine_y = { 'location' },
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
