return
{
    "jcdickinson/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("codeium").setup({
        })
    end
}
