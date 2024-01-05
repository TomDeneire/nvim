return {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("ibl").setup {
            indent = { char = "|" },
            scope = {
                char = "|",
                enabled = true,
                show_start = false,
                show_end = false
            },
        }
    end
}
