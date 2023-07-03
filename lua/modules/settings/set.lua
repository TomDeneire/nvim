-- General settings
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.list = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.showtabline = 2
vim.opt.ignorecase = true
vim.o.smartcase = true
vim.opt.autochdir = true
vim.opt.linebreak = true
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.background = ""
vim.wo.colorcolumn = '80'
vim.o.helpheight = 30

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

-- python settings
vim.g.python_version_2 = 0
vim.g.python_highlight_all = 1
-- to do: why do pylsp and pyright use python3.10 as executable?
vim.g.python3_host_prog = '/home/tdeneire/bin/py3'
vim.g.python_host_prog = '/home/tdeneire/bin/py3'

-- for markdown
vim.opt.foldenable = false
vim.opt.conceallevel = 0

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 500

-- Vim style remappings (don't work in pure Lua)
local cmd = "vmap <silent> cc :call nerdcommenter#Comment('x', 'toggle')<CR>"
vim.cmd(cmd)
cmd = "nnoremap <c-[> <c-^>"
vim.cmd(cmd)
cmd = "inoremap <c-s> <ESC>:w<CR>"
vim.cmd(cmd)

-- Disable macro recording
local cmd = "map q <Nop>"
vim.cmd(cmd)

return {}
