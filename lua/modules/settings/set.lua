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

-- Show mode only in statusline
vim.opt.showmode = false

-- Highlighting cursorword
vim.g.cursorword_disable_filetypes = { "markdown", "html", "xml", "json", "bfile", "dfile", "rst" }

-- Tabsettings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Split a string on a delimiter
function _split(mystring, delim)
    local result = {}
    local start = 1

    while (true) do
        local _, pos = string.find(mystring, delim, start, true)
        if pos == nil then
            local rest = string.sub(mystring, start, string.len(mystring))
            table.insert(result, rest)
            break
        else
            local matchlen = pos - string.len(delim)
            local part = string.sub(mystring, start, matchlen)
            start = pos + 1
            table.insert(result, part)
        end
    end

    return result
end

-- LSP settings
vim.diagnostic.config(
    {
        underline = false,
        virtual_text = false,
        -- virtual_text = {
        --     spacing = 2,
        --     prefix = "●",
        --     format =
        --         function(diagnostic)
        --             local message = diagnostic.message
        --             if string.match(message, "msg=") then
        --                 message = _split(message, "msg=")[2]
        --             end
        --             return string.sub(message, 1, 50) .. "..."
        --         end
        -- },
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

-- Disable q for macro recording
vim.cmd("map q <Nop>")

-- Remove tildes
vim.cmd("set fillchars=eob:\\ ")

return {}
