return {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
        {
            "supermaven-inc/supermaven-nvim",
            config = function()
                -- Provide a fake cmp module so supermaven doesn't warn about missing nvim-cmp
                package.preload["cmp"] = function()
                    return { register_source = function() end }
                end
                require("supermaven-nvim").setup({
                    disable_inline_completion = true,
                    disable_keymaps = true,
                })
                package.preload["cmp"] = nil
            end,
        },
        {
            "huijiro/blink-cmp-supermaven"
        },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        sources = {
            default = { "lsp", 'path', "supermaven", "snippets", 'buffer' },
            providers = {
                supermaven = {
                    name = 'supermaven',
                    module = "blink-cmp-supermaven",
                    async = true
                }
            }
        },
        cmdline = {
            enabled = true,
            keymap = { preset = "cmdline" },
            completion = {
                list = { selection = { preselect = false } },
                menu = {
                    auto_show = function(ctx)
                        return vim.fn.getcmdtype() == ":"
                    end,
                },
                ghost_text = { enabled = true },
            },
        },
        keymap = {
            preset = "super-tab",
        },
    }
}
