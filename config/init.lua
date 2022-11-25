-- General lua settings for neovim
vim.g.mapleader = ' '

-- buffer-scoped
vim.opt.autoindent = true

-- window-scoped
vim.opt.cursorline = true

-- global scope
vim.opt.autowrite = true

vim.wo.colorcolumn = '80'

-- Nvim-web-devicons
require('spunkshui.devicons')

-- Nvim-tree
require('spunkshui.tree')

-- Telescope
require('spunkshui.telescope')

-- Lualine
require('spunkshui.lualine')

vim.opt.list = true

-- Indent blankline
require('spunkshui.blankline')

-- LSP configs
require('spunkshui.lsp')

-- Treesitter
require('spunkshui.treesitter')

-- Terminal
require('spunkshui.terminal')

-- Bufferline
require('spunkshui.bufferline')

require("spunkshui.hello")
