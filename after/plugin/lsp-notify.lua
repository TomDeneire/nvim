if vim.g.vscode then
    return
end

require("lsp-notify").setup({ exclude_codes = { E501 = true } })
