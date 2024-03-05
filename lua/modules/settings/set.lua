-- General settings
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.list = false
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.showtabline = 2
vim.opt.ignorecase = true
vim.o.smartcase = true
vim.opt.autochdir = true
vim.opt.linebreak = true
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.background = "dark"
vim.o.mouse = ""
vim.wo.colorcolumn = '80'

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- highlighting cursorword
vim.g.cursorword_disable_filetypes = { "markdown", "html", "xml", "json", "bfile", "dfile", "rst" }

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
-- set python executables (not related to LSP)
vim.g.python3_host_prog = '/home/tdeneire/bin/py3'
vim.g.python = '/home/tdeneire/bin/py3'

-- for markdown
vim.opt.foldenable = false
vim.opt.conceallevel = 0

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 500

-- Vim style remappings (don't work in pure Lua)
cmd = "nnoremap <c-[> <c-^>"
vim.cmd(cmd)
cmd = "inoremap <c-s> <ESC>:w<CR>"
vim.cmd(cmd)

-- Disable macro recording
local cmd = "map q <Nop>"
vim.cmd(cmd)

-- Remove tildes
vim.cmd("set fillchars=eob:\\ ")

return {}
