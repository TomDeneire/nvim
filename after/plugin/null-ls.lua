-- null-ls (only used for formatting)
if not vim.g.vscode
then
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.xmlformat,
        },
    })
end
