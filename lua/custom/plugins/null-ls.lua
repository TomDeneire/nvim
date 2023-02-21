if vim.g.vscode then
    return
end
-- null-ls (only used for formatting)
local null_ls = require("null-ls")

null_ls.setup({
    autostart = true,
    sources = {
        null_ls.builtins.formatting.xmlformat,
        null_ls.builtins.formatting.prettier,
    },
})

return {}
