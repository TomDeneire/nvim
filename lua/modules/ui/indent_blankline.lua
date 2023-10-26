return {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("ibl").setup {
            indent = { char = "|" },
            scope = {
                char = "|",
                enabled = false,
                show_start = true,
                show_end = true
            },
        }
    end
}
