return {
    {
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

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'markdown',
                callback = function()
                    vim.opt_local.conceallevel = 2
                    vim.opt_local.concealcursor = 'nc'
                end,
            })
        end
    },
    {
        'shortcuts/no-neck-pain.nvim',
        version = '*',
        opts = { width = 100, buffers = { wo = { statusline = ' ' } } },
        config = function(_, opts)
            require('no-neck-pain').setup(opts)

            vim.api.nvim_create_autocmd('BufEnter', {
                callback = function(args)
                    vim.schedule(function()
                        if not vim.api.nvim_buf_is_valid(args.buf) then
                            return
                        end
                        if vim.bo[args.buf].buftype ~= '' or not vim.bo[args.buf].buflisted then
                            return
                        end
                        if vim.api.nvim_win_get_config(0).relative ~= '' then
                            return
                        end

                        local enabled = _G.NoNeckPain and _G.NoNeckPain.state and _G.NoNeckPain.state.enabled
                        local is_markdown = vim.bo[args.buf].filetype == 'markdown'

                        if is_markdown and not enabled then
                            require('no-neck-pain').enable()
                        elseif not is_markdown and enabled then
                            require('no-neck-pain').disable()
                        end
                    end)
                end,
            })
        end
    },
}
