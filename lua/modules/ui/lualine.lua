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
        require("lualine").setup {
            options = {
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
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
                lualine_c = { { lsp_spinner } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end
}
