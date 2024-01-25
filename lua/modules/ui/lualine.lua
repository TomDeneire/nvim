local branch = {
    'branch',
    icon = ''
}

local diff = {
    'diff',
    color = { bg = '#393836' }
}

local diagnostics = {
    'diagnostics',
    color = { bg = '#393836' }
}

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
                lualine_b = { diff, diagnostics },
                lualine_c = { branch, "vim.fn.expand('%:p')", require('lsp-progress').progress },
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
            },
            inactive_winbar = {},
            extensions = { disable_extension },
        }
        -- listen lsp-progress event and refresh lualine
        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = require("lualine").refresh,
        })
    end
}
