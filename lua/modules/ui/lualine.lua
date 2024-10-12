local function mode_fmt(mode)
    local icon = ""
    if mode == "NORMAL" then
        icon = "󰆾"
    elseif mode == "INSERT" then
        icon = ""
    elseif mode == "COMMAND" then
        icon = ""
    elseif mode == "SELECT" then
        icon = "󰩬"
    elseif mode == "VISUAL" then
        icon = ""
    elseif mode == "V-LINE" then
        icon = ""
    elseif mode == "TERMINAL" then
        icon = ""
    else
        icon = ""
    end
    return icon .. " " .. mode
end

local function truncate(filepath)
    local max_length = math.floor(vim.o.columns / 3)
    local total_length = string.len(filepath)
    if total_length > max_length then
        local truncator = "…"
        local startpos = 1 + (total_length - max_length) + string.len(truncator)
        return truncator .. string.sub(filepath, startpos, total_length)
    else
        return filepath
    end
end

-- Sections
local mode = {
    'mode',
    fmt = mode_fmt
}

local branch = {
    'branch',
    icon = ''
}

local filename = {
    "filename",
    path = 3,
    fmt = truncate
}

local lsp_progress = {
    require('lsp-progress').progress,
}


local diff = {
    'diff',
    symbols = {
        added = " ",
        modified = " ",
        removed = " "
    },
}

local progress = {
    'progress',
}

local encoding = {
    'encoding',
}

local filetype = {
    'filetype',
    icon_only = true
}

local diagnostics = {
    'diagnostics',
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
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
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
                lualine_c = { branch, filename, lsp_progress },
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
