return {
    'saghen/blink.cmp',
    build = 'cargo build --release',
    dependencies = {
        {
            "supermaven-inc/supermaven-nvim",
            opts = {
                disable_keymaps = true,
            },
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
