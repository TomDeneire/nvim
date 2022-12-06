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

vim.opt.list = true

-- Indent blankline
require('spunkshui.blankline')

-- Terminal
require('spunkshui.terminal')

-- Bufferline
require('spunkshui.bufferline')

require("spunkshui.hello")

-- (source editorconfig.nvim)
function Trim_trailing_whitespace()
    local view = vim.fn.winsaveview()
    vim.api.nvim_command("silent! undojoin")
    vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
    return vim.fn.winrestview(view)
end
