if vim.g.vscode then
    return
end

vim.g.mapleader = ' '

-- basic
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<c-a>", "ggVG")
vim.keymap.set("n", "<c-i>", vim.lsp.buf.hover)
vim.keymap.set("n", "<c-s>", ":w<CR>")
vim.keymap.set("i", "<c-s>", "<ESC> :w<CR>")
vim.keymap.set("n", "<c-j>", "10j")
vim.keymap.set("v", "<c-j>", "10j")
vim.keymap.set("n", "<c-k>", "10k")
vim.keymap.set("v", "<c-k>", "10k")
vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>")
vim.keymap.set("n", "tl", "<cmd>silent :bn<CR>")
vim.keymap.set("n", "th", "<cmd>silent :bp<CR>")
vim.keymap.set("n", "td", "<cmd>silent lua MiniBufremove.delete()<CR>")
vim.keymap.set("n", "<c-v>", '"*p')
vim.keymap.set("v", "<c-c>", '"+y')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- plugins
vim.keymap.set("n", "tt", "<cmd>silent :Telescope file_browser<CR>")
vim.keymap.set("n", "ff", "<cmd>silent :Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>old", require('telescope.builtin').oldfiles)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<c-D>", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>lg", "<cmd>silent :LazyGit<CR>")
vim.keymap.set("n", "<leader>lsp", vim.diagnostic.open_float)

-- qtechng (to do: refactor Lua functions to local functions like below)
vim.keymap.set("n", "<c-b>", ":!qtechng file ci<CR>")
vim.keymap.set("n", "<c-o>", ":!qtechng file refresh<CR>")
vim.keymap.set("n", "<leader>rou", "<cmd>silent lua JumpToRou()<CR>")
vim.keymap.set("n", "<c-m>", "<cmd>silent lua DefineMacro()<CR>")
vim.keymap.set("n", "<leader>qg", "<cmd>silent lua OpenInGit()<CR>")
vim.keymap.set("n", "<leader>qp", "<cmd>silent lua ComparePrevious()<CR>")
vim.keymap.set("n", "<leader>qs", "<cmd>lua SourceList()<CR>")
vim.keymap.set("n", "<leader>qm", "<cmd>lua MacroList()<CR>")
vim.keymap.set("v", "<leader>qt", ":norm xi .<CR>")
vim.keymap.set("n", "<leader>qn", "mnviwy?^ n <CR>A,<ESC>pviwy`n")
vim.keymap.set("n", "<leader>ql",
    ":!qtechng file list --changed --cwd=$(qtechng registry get qtechng-work-dir) --recurse | jq -r .DATA[0].qpath<CR>")


-- toggle term
local Terminal = require('toggleterm.terminal').Terminal
local newterm  = Terminal:new({ cwd = vim.fn.getcwd(), hidden = true })

function _term_toggle()
    newterm:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>term", "<cmd>lua _term_toggle()<CR>", { noremap = true, silent = true })

-- other
vim.keymap.set("n", "<c-p>", "<cmd>silent lua FindInWorkSpace()<CR>")
vim.keymap.set("n", "<c-f>", "<cmd>silent lua GrepInWorkSpace()<CR>")
vim.keymap.set("n", "<leader>grep", "<cmd>silent lua GrepPattern()<CR>")
vim.keymap.set("n", "<leader>flake", ':cexpr system("flake8 " . shellescape(expand("%")))<CR> :copen<CR>')
vim.keymap.set("n", "<leader>black", "<cmd>silent :!black %:p --config=/home/tdeneire/.config/black/pyproject.toml<CR>")
return {}
