function _term_toggle()
    local Terminal = require('toggleterm.terminal').Terminal
    local newterm  = Terminal:new({ cwd = vim.fn.getcwd(), hidden = true })
    newterm:toggle()
end

return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    lazy = true,
    keys = {
        { "<leader>term", "<cmd>silent lua _term_toggle()<cr>", silent = true, desc = "Start terminal", mode = "n" } },
}
