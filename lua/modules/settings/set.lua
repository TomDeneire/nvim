-- General settings
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.hlsearch = true
vim.opt.showtabline = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autochdir = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.background = "dark"
vim.opt.mouse = ""
vim.opt.colorcolumn = '80'
vim.g.have_nerd_font = true

-- No whitespace
vim.opt.list = false

-- Sync clipboard between OS and Neovim
-- on Linux this needs xsel
vim.opt.clipboard = 'unnamedplus'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show mode only in statusline
vim.opt.showmode = false

-- Highlighting cursorword
vim.g.cursorword_disable_filetypes = { "markdown", "html", "xml", "json", "rst" }

-- Tabsettings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Diagnostics
vim.diagnostic.config({
    underline = false,
    virtual_text = false,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
})

-- Backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Python settings
vim.g.python_version_2 = 0
vim.g.python_highlight_all = 1
-- set python executables (not related to LSP)
vim.g.python3_host_prog = vim.fn.exepath('python3')
vim.g.python = vim.fn.exepath('python3')

-- For markdown
vim.opt.foldenable = false
vim.opt.conceallevel = 0

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- Remove tildes
vim.opt.fillchars = { eob = " " }

return {}
