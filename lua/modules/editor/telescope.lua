return
{
    'nvim-telescope/telescope.nvim',
    event = "VimEnter",
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
        {
            'catgoose/telescope-helpgrep.nvim',
            event = "VeryLazy"
        },
        {
            "debugloop/telescope-undo.nvim",
            event = "VeryLazy"
        }
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
                    disable_devicons = false,
                    sorting_strategy = "descending",
                    prompt_prefix = "🔍 ",
                    scroll_strategy = "cycle",
                    path_display = { "absolute", "truncate" }
                },
                live_grep = {
                    disable_devicons = false,
                    prompt_prefix = "🔍 ",
                    sorting_strategy = "descending",
                    scroll_strategy = "cycle"
                },
            },
            extensions = {
                ['ui-select'] = { require('telescope.themes').get_dropdown() },
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                },
                file_browser = {
                    sorting_strategy = "descending",
                    hijack_netrw = true,
                    dir_icon = "",
                    hidden = true,
                    respect_gitignore = false
                },
                helpgrep = {
                    ignore_paths = {
                        vim.fn.stdpath("state") .. "/lazy/readme",
                    },
                }
            }
        }

        pcall(require('telescope').load_extension('fzf'))
        pcall(require('telescope').load_extension('file_browser'))
        pcall(require('telescope').load_extension('helpgrep'))
        pcall(require('telescope').load_extension('undo'))
    end
}
