local opts = {
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'cc',
        ---Block-comment keymap
        block = 'gb',
    },
    --NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
    },
}

return {
    'numToStr/Comment.nvim',
    event = { "BufReadPost", "BufNewFile" },
    lazy = false,
    config = function()
        require('Comment').setup(opts)
    end
}
