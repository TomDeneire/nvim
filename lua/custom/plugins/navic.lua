return
{
    "SmiteshP/nvim-navic",
    init = function()
        vim.g.navic_silence = true
    end,
    opts = function()
        return {
            icons = {
                File          = " ",
                Module        = " ",
                Namespace     = " ",
                Package       = " ",
                Class         = " ",
                Method        = " ",
                Property      = " ",
                Field         = " ",
                Constructor   = " ",
                Enum          = "練",
                Interface     = "練",
                Function      = " ",
                Variable      = " ",
                Constant      = " ",
                String        = " ",
                Number        = " ",
                Boolean       = "◩ ",
                Array         = " ",
                Object        = " ",
                Key           = " ",
                Null          = "ﳠ ",
                EnumMember    = " ",
                Struct        = " ",
                Event         = " ",
                Operator      = " ",
                TypeParameter = " ",
            },
            lsp = {
                auto_attach = true,
                preference = nil,
            },
            depth_limit_indicator = "..",
            safe_output = true,
            separator = " ",
            highlight = false,
            depth_limit = 0
        }
    end,
}
