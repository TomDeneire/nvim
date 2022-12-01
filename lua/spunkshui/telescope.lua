-- Telescope
require('telescope').setup{
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
         scroll_strategy = "limit"},
	live_grep = {
         theme = "ivy",
		 disable_devicons = false,
         prompt_prefix = "🔍 ",
		 sorting_strategy = "ascending",
         scroll_strategy = "limit"},
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')
