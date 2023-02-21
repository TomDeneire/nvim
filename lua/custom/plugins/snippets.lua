if vim.g.vscode then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

return {}
