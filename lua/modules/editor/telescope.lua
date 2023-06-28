return
{
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    version = '*',
    dependencies =
    { { 'nvim-lua/plenary.nvim' },
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            event = "VeryLazy",
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        {
            'nvim-telescope/telescope-file-browser.nvim',
            event = "VeryLazy"
        },
    },
    config = function()
        require('telescope').setup {
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                vimgrep_arguments = {
                    'rg',
                    --'--color=never',
                    --'--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--no-ignore',
                    '--ignore-file',
                    '.gitignore'
                },
                layout_strategy = "horizontal",
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ["<C-h>"] = "which_key"
                    }
                }
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
                find_files = {
                    theme = "ivy",
                    disable_devicons = false,
                    sorting_strategy = "ascending",
                    prompt_prefix = "🔍 ",
                    scroll_strategy = "limit"
                },
                live_grep = {
                    theme = "ivy",
                    disable_devicons = false,
                    prompt_prefix = "🔍 ",
                    sorting_strategy = "ascending",
                    scroll_strategy = "limit"
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                    dir_icon = "",
                    hidden = true,
                }
            }
        }

        require('telescope').load_extension('fzf')

        require('telescope').load_extension('file_browser')
    end
}
