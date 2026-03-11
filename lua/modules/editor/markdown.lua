return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true }, blink = { enabled = true } },
            code = { sign = false },
            bullet = {
                enabled = true,
                icons = { '●', '○', '◆', '◇' },
                ordered_icons = function(ctx)
                    local value = vim.trim(ctx.value)
                    local index = tonumber(value:sub(1, #value - 1))
                    return ('%d.'):format(index > 1 and index or ctx.index)
                end,
            },
            heading = {
                enabled = true,
                sign = false,
                position = 'overlay',
                icons = { '# ', '## ', '### ', '### ', '#### ', '##### ' },
                width = 'block',
            },
        })
    end
}
