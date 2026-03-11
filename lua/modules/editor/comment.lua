return {
    'numToStr/Comment.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        opleader = { line = 'cc', block = 'gb' },
        mappings = { basic = true, extra = false },
    },
}
