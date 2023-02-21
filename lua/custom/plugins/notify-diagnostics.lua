if vim.g.vscode then
    return
end

require("notify-diagnostics").setup({ exclude_codes = { E501 = true } })

return {}
