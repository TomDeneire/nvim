if vim.g.vscode then
  return
end

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

-- Define Lazy plugins
-- NOTE: Beware of the order of the modules and of the files within the modules!
-- NOTE: Do not call modules which do not follow plugin spec here (e.g. color, qtechng)
local plugins = {
  { import = 'modules.editor' },
  { import = 'modules.lsp' },
  { import = 'modules.ui' },
  { import = 'modules.settings' },
}

-- Load Lazy plugins
local lazy_opts = {
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = true, -- get a notification when changes are found
  },
}

require('lazy').setup(plugins, lazy_opts)

-- colorscheme
vim.cmd.colorscheme("gruvbox")
-- better quickfixlist
require("modules.color").better_quickfixlist()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
