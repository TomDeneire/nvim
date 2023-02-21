-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'kdheepak/lazygit.nvim',
  'lewis6991/gitsigns.nvim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim' },


  -- My plugins
  { 'kyazdani42/nvim-web-devicons' },
  { 'ray-x/lsp_signature.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'akinsho/bufferline.nvim' },
  { 'shortcuts/no-neck-pain.nvim' },
  { 'tomdeneire/notify-diagnostics.nvim',
    dependencies = { 'rcarriga/nvim-notify' },
  },
  { 'preservim/nerdcommenter', },
  { 'mbbill/undotree',            lazy = true },
  { 'preservim/vim-markdown',     lazy = true },
  { 'vim-python/python-syntax',   lazy = true },
  { 'akinsho/toggleterm.nvim',    lazy = true },
  { 'echasnovski/mini.bufremove', lazy = true },
  { 'martinsione/darkplus.nvim',  lazy = true },
  { 'mhartington/oceanic-next',   lazy = true },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '|', right = '  ' },
        section_separators = { left = '  ', right = '  ' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'branch', "vim.fn.expand('%:p')" },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = {},
        lualine_z = { 'progress' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = { 'branch' },
        lualine_c = {},
        lualine_x = { 'fileformat' },
        lualine_y = { 'location' },
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
    }
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
  },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',
    version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { 'nvim-telescope/telescope-file-browser.nvim' },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
}, {})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- Setup neovim lua configuration
require('neodev').setup()



-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
