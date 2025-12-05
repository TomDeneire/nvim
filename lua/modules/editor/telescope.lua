return
{
    'nvim-telescope/telescope.nvim',
    dependencies =
    { { 'nvim-lua/plenary.nvim' },
        {
            'nvim-telescope/telescope-file-browser.nvim',
            event = "VeryLazy"
        },
        {
            "debugloop/telescope-undo.nvim",
            event = "VeryLazy"
        },
    },
    keys = {
        { "tt",        "<cmd>silent :Telescope file_browser<CR>", desc = "Open Telescope File Browser" },
        { "<leader>u", "<cmd>Telescope undo<cr>",                 desc = "Undotree" }
    },
    config = function()
        require('telescope').setup {
            extensions = {
                file_browser = {
                    sorting_strategy = "descending",
                    hijack_netrw = true,
                    dir_icon = "",
                    hidden = true,
                    respect_gitignore = false
                },
            }
        }
    end
}
