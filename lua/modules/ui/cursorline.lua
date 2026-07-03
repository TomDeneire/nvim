return {
    'ya2s/nvim-cursorline',
    event = "BufReadPost",
    opts = {
        disable_filetypes = { "cmd", "msg", "dialog", "pager" },
        cursorline = { enable = false },
        cursorword = {
            enable = true,
            min_length = 3,
            hl = { underline = true },
        },
    },
}
