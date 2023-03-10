if vim.g.vscode then
    return
end

return {
    'tomdeneire/notify-diagnostics.nvim',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { 'rcarriga/nvim-notify' },
    branch = "dev",
    config = function()
        require("notify-diagnostics").setup({ exclude_codes = { E501 = true } })
        local max_width = math.floor(vim.o.columns * 0.25)
        require("notify").setup({ max_width = max_width })
    end
}
