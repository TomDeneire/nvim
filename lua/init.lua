-- General settings

vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.list = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.showtabline = 2
vim.opt.ignorecase = true
vim.opt.autochdir = true

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tabsettings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.wo.colorcolumn = '80'

vim.g.python_version_2 = 0
vim.g.python_highlight_all = 1

-- for markdown
vim.opt.foldenable = false
vim.opt.conceallevel = 0

--
-- Nvim-web-devicons
require('spunkshui.devicons')

-- Nvim-tree
require('spunkshui.tree')

-- Telescope
require('spunkshui.telescope')

-- Indent blankline
require('spunkshui.blankline')

-- Terminal
require('spunkshui.terminal')

-- Bufferline
require('spunkshui.bufferline')

-- General utils
require("spunkshui.utils")

-- QtechNG
require("spunkshui.qtechng")

-- keymappings
require('spunkshui.keymappings')
