return {
    'ya2s/nvim-cursorline',
    event = "BufReadPost",
    opts = {
        cursorline = { enable = false },
        cursorword = {
            enable = true,
            min_length = 3,
            hl = { underline = true },
        },
    },
}
