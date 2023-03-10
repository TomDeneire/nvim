if vim.g.vscode then
    return
end

-- Telescope
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
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
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

local function getfinddir()
    local workspace = vim.fn.getcwd()
    local sourcedir = "/brocade/source/data"
    local packagesdir = "/brocade/packages"
    local qtechng_work_dir = "/home/tdeneire/projects/brocade/source/data"
    local packages_work_dir = "/home/tdeneire/projects/brocade/packages"
    local projects_work_dir = "/home/tdeneire/projects/code"
    if string.find(workspace, sourcedir) ~= nil then
        return qtechng_work_dir
    elseif string.find(workspace, packagesdir) ~= nil then
        return packages_work_dir
    else
        return projects_work_dir
    end
end

function FindInWorkSpace()
    local find_dir = getfinddir()
    require("telescope.builtin").find_files(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = find_dir
        })
end

function GrepInWorkSpace()
    local find_dir = getfinddir()
    require("telescope.builtin").live_grep(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = find_dir
        })
end

function GrepPattern()
    local find_dir = getfinddir()
    local pattern = vim.fn.input("Grep_pattern=", "*.")
    require("telescope.builtin").live_grep(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = find_dir,
            glob_pattern = pattern
        })
end

return {}
