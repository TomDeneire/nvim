-- SOURCE: https://github.com/nvim-lua/kickstart.nvim

-- Disable config when using Neovim through VSCode
if vim.g.vscode then
  return
end

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
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

-- Define Lazy plugins
-- NOTE: Beware of the order of the modules and of the files within the modules!
local plugins = {
  { import = 'modules.editor' },
  { import = 'modules.lsp' },
  { import = 'modules.ui' },
  { import = 'modules.settings' },
  { import = 'modules.remap' },
}

-- Lazy options
local lazy_opts = {
  change_detection = {
    enabled = false,
    notify = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

-- Load plugins
require('lazy').setup(plugins, lazy_opts)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
