if vim.g.vscode then
    return
end

return {
    'echasnovski/mini.bufremove',
    version = '*',
    config = function()
        require('mini.bufremove').setup()
    end
}
