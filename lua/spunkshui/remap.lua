vim.g.mapleader = ' '

-- basic
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<c-a>", "ggVG")
vim.keymap.set("n", "<c-i>", "<cmd>silent lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<c-s>", ":w<CR>")
vim.keymap.set("i", "<c-s>", "<ESC> :w<CR>")
vim.keymap.set("n", "<c-j>", "10j")
vim.keymap.set("v", "<c-j>", "10j")
vim.keymap.set("n", "<c-k>", "10k")
vim.keymap.set("v", "<c-k>", "10k")
vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>")
vim.keymap.set("n", "tl", "<cmd>silent :bn<CR>")
vim.keymap.set("n", "th", "<cmd>silent :bp<CR>")

-- plugins
vim.keymap.set("n", "tt", "<cmd>silent :NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>old", "<cmd>silent :Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>ca", "<cmd>silent lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<c-D>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>term", "<cmd>:ToggleTerm dir=getcwd()<CR>")
vim.keymap.set("n", "<leader>def", "<cmd>silent :Lspsaga peek_definition<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>silent :Lspsaga rename<CR>")
vim.keymap.set("n", "<leader>all", ":tab ba<CR> :NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tree", "<cmd>silent :LSoutlineToggle<CR>")
vim.keymap.set("n", "<leader>ls",
    '<cmd>lua require("telescope.builtin").find_files({no_ignore = true, no_ignore_parent = true})<CR>')

-- qtechng
vim.keymap.set("n", "<c-b>", ":!qtechng file ci %:p<CR>")
vim.keymap.set("n", "<c-o>", ":!qtechng file refresh<CR>")
vim.keymap.set("n", "<leader>rou", "<cmd>silent lua JumpToRou()<CR>")
vim.keymap.set("n", "<c-m>", "<cmd>silent lua DefineMacro()<CR>")
vim.keymap.set("n", "<leader>qg", "<cmd>silent lua OpenInGit()<CR>")
vim.keymap.set("n", "<leader>qp", "<cmd>silent lua ComparePrevious()<CR>")
vim.keymap.set("n", "<leader>qs", "<cmd>lua SourceList()<CR>")
vim.keymap.set("n", "<leader>qm", "<cmd>lua MacroList()<CR>")

-- other
vim.keymap.set("n", "<c-p>", "<cmd>silent lua FindInWorkSpace()<CR>")
vim.keymap.set("n", "<c-f>", "<cmd>silent lua GrepInWorkSpace()<CR>")
vim.keymap.set("n", "<leader>grep", "<cmd>silent lua GrepPattern()<CR>")
vim.keymap.set("n", "<leader>flake", ':cexpr system("flake8 " . shellescape(expand("%")))<CR> :copen<CR>')
vim.keymap.set("n", "<leader>black", "<cmd>silent :!black %:p<CR>")

-- vim.keymap.set("n", "<c-[>", "c-^")
-- vim.keymap.set("n", "<c-v>", '"*p')
-- vim.keymap.set("i", "<c-v>", '<ESC> "*pa')
-- vim.keymap.set("v", "<c-c>", '"+y')
