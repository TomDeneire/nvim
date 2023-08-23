-- null-ls (only used for formatting)

return {
    'jose-elias-alvarez/null-ls.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            autostart = true,
            sources = {
                null_ls.builtins.formatting.xmlformat,
                null_ls.builtins.formatting.djlint,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua,
            },
        })
    end
}
