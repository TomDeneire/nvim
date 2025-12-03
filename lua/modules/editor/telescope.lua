return
{
    'nvim-telescope/telescope.nvim',
    event = "VimEnter",
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

        pcall(require('telescope').load_extension('file_browser'))
        pcall(require('telescope').load_extension('undo'))
    end
}
