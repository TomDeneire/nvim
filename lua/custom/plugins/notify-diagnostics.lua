if vim.g.vscode then
    return
end

return {
    'tomdeneire/notify-diagnostics.nvim',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { 'rcarriga/nvim-notify' },
    config = function()
        require("notify-diagnostics").setup({ exclude_codes = { E501 = true } })
    end
}
