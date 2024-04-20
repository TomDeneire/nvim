-- General settings
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.hlsearch = true
vim.opt.showtabline = 2
vim.opt.ignorecase = true
vim.o.smartcase = true
vim.opt.autochdir = true
vim.opt.linebreak = true
vim.o.breakindent = true
vim.o.background = "dark"
vim.o.mouse = ""
vim.wo.colorcolumn = '80'
vim.g.have_nerd_font = true
-- vim.o.scrolloff = 10

-- No whitespace
vim.opt.list = false

-- Sync clipboard between OS and Neovim
-- on Linux this needs xsel
vim.o.clipboard = 'unnamedplus'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show mode only in satusline
vim.opt.showmode = false

-- Highlighting cursorword
vim.g.cursorword_disable_filetypes = { "markdown", "html", "xml", "json", "bfile", "dfile", "rst" }

-- Tabsettings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- LSP settings
vim.diagnostic.config(
    {
        underline = true,
        virtual_text = false,
        -- virtual_text = {
        --     spacing = 2,
        --     prefix = "●",
        -- },
        update_in_insert = false,
        severity_sort = true,
    }
)

-- Backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Python settings
vim.g.python_version_2 = 0
vim.g.python_highlight_all = 1
-- set python executables (not related to LSP)
vim.g.python3_host_prog = '/home/tdeneire/bin/py3'
vim.g.python = '/home/tdeneire/bin/py3'

-- For markdown
vim.opt.foldenable = false
vim.opt.conceallevel = 0

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 500

-- Vim style remappings (don't work in pure Lua)
vim.cmd("nnoremap <c-[> <c-^>")
vim.cmd("inoremap <c-s> <ESC>:w<CR>")

-- Disable macro recording
vim.cmd("map q <Nop>")

-- Remove tildes
vim.cmd("set fillchars=eob:\\ ")

return {}
