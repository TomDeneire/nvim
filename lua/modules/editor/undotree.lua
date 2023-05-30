return {
    "jiaoshijie/undotree",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>u", ":lua require('undotree').toggle()<cr>", silent = true, desc = "Show undotree", mode = "n" } },
    config = function()
        require("undotree").setup()
    end
}
