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
vim.keymap.set("n", "tn", "<cmd>silent :tabnew<CR>")
vim.keymap.set("n", "tl", "<cmd>silent :+tabnext<CR>")
vim.keymap.set("n", "th", "<cmd>silent :-tabnext<CR>")

-- plugins
vim.keymap.set("n", "tt", "<cmd>silent :NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>old", "<cmd>silent :Telescope oldfiles<CR>")
vim.keymap.set("n", "<c-D>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>term", "<cmd>:ToggleTerm dir=getcwd()<CR>")
vim.keymap.set("n", "<leader>def", "<cmd>silent :Lspsaga peek_definition<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>silent :Lspsaga rename<CR>")
vim.keymap.set("n", "<leader>all", ":tab ba<CR> :NvimTreeToggle<CR>")
vim.keymap.set("v", "<leader>cc", "<cmd>silent :call nerdcommenter#Comment('x', 'toggle')<CR>")

-- qtechng
vim.keymap.set("n", "<c-b>", ":!qtechng file ci %:p<CR>")
vim.keymap.set("n", "<c-o>", ":!qtechng file refresh<CR>")

-- other
vim.keymap.set("n", "<leader>flake", ':cexpr system("flake8 " . shellescape(expand("%")))<CR> :copen<CR>')
vim.keymap.set("n", "<leader>black", "<cmd>silent :!black %:p<CR>")

-- vim.keymap.set("n", "<c-[>", "c-^")
-- vim.keymap.set("n", "<c-v>", '"*p')
-- vim.keymap.set("i", "<c-v>", '<ESC> "*pa')
-- vim.keymap.set("v", "<c-c>", '"+y')
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
