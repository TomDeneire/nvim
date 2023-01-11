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
vim.opt.linebreak = true

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tabsettings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.wo.colorcolumn = '80'

vim.g.python_version_2 = 0
vim.g.python_highlight_all = 1
vim.g.python3_host_prog = '/home/tdeneire/bin/py3'

-- for markdown
vim.opt.foldenable = false
vim.opt.conceallevel = 0

-- for which_key
vim.opt.timeoutlen = 500
