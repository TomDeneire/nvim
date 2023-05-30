return {
    'echasnovski/mini.bufremove',
    version = '*',
    lazy = true,
    keys = {
        { "td", "<cmd>silent lua MiniBufremove.delete()<cr>", desc = "Remove buffer", mode = "n" } },
    config = function()
        require('mini.bufremove').setup()
    end
}
