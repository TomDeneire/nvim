-- General lua settings for neovim

-- buffer-scoped
vim.opt.autoindent = true

-- window-scoped
vim.opt.cursorline = true

-- global scope
vim.opt.autowrite = true
vim.opt.list = true

vim.wo.colorcolumn = '80'

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

-- Greeting
require("spunkshui.hello")
