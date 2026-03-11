local function mode_fmt(mode)
    local icons = {
        NORMAL = "󰆾",
        INSERT = "",
        COMMAND = "",
        SELECT = "󰩬",
        VISUAL = "",
        ["V-LINE"] = "",
        TERMINAL = "",
    }
    return (icons[mode] or "") .. " " .. mode
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
                    { 'diff', symbols = { added = " ", modified = " ", removed = " " } },
                    'diagnostics',
                },
                lualine_c = { { function() return require('lsp-progress').progress() end } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
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
