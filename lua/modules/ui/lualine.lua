local colors = require("modules.color").colors()

-- Sections
local branch = {
    'branch',
    color = { fg = colors.white, bg = colors.statusline_bg },
    icon = ''
}

local filepath = {
    "vim.fn.expand('%:p')",
    color = { fg = colors.white, bg = colors.statusline_bg }
}

local lsp_progress = {
    require('lsp-progress').progress,
    color = { fg = colors.white, bg = colors.statusline_bg }
}

local mode = {
    'mode',
    color = { fg = colors.statusline_bg }
}

local diff = {
    'diff',
    color = { fg = colors.white, bg = colors.statusline_bg }
}

local progress = {
    'progress',
    color = { fg = colors.white, bg = colors.statusline_bg }
}

local encoding = {
    'encoding',
    color = { fg = colors.white, bg = colors.statusline_bg }
}

local filetype = {
    'filetype',
    color = { fg = colors.white, bg = colors.statusline_bg }
}

local diagnostics = {
    'diagnostics',
    color = { fg = colors.white, bg = colors.statusline_bg }
}

local colors = {
    color5  = colors.blue,
    color6  = colors.grey,
    color7  = colors.grey,
    color10 = colors.orange,
    color13 = colors.purple,
    color14 = colors.green,
    color0  = colors.white,
    color1  = colors.grey,
    color4  = colors.statusline_bg,
}

-- Custom theme
local theme = {
    visual = {
        b = { fg = colors.color0, bg = colors.color1 },
        a = { fg = colors.color4, bg = colors.color5, gui = 'bold' },
    },
    inactive = {
        b = { fg = colors.color6, bg = colors.color4 },
        c = { fg = colors.color6, bg = colors.color4 },
        a = { fg = colors.color7, bg = colors.color4, gui = 'bold' },
    },
    insert = {
        b = { fg = colors.color0, bg = colors.color1 },
        a = { fg = colors.color4, bg = colors.color10, gui = 'bold' },
    },
    replace = {
        b = { fg = colors.color0, bg = colors.color1 },
        a = { fg = colors.color4, bg = colors.color13, gui = 'bold' },
    },
    normal = {
        b = { fg = colors.color0, bg = colors.color1 },
        c = { fg = colors.color7, bg = colors.color4 },
        a = { fg = colors.color4, bg = colors.color14, gui = 'bold' },
    },
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
                theme = theme,
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
                lualine_a = { mode },
                lualine_b = { diff, diagnostics },
                lualine_c = { branch, filepath, lsp_progress },
                lualine_x = { encoding, filetype },
                lualine_y = {},
                lualine_z = { progress }
            },
            tabline = {},
            winbar = {
            },
            inactive_winbar = {},
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
