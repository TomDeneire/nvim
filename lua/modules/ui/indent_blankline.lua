return {
    'lukas-reineke/indent-blankline.nvim',
    -- Note: "event" lazy-loading conflicts with the "exclude" parameter!
    -- event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    ft = require("modules.utils").lsp_filetypes,
    config = function()
        require("ibl").setup {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false
            },
        }
    end
}
