-- Disable q for macro recording, use <leader>m instead
vim.keymap.set("", "q", "<Nop>")
vim.keymap.set("n", "<leader>m", "q", { desc = "Record macro" })

-- Switch to alternate buffer
vim.keymap.set("n", "<c-[>", "<c-^>")

-- Save from insert mode
vim.keymap.set("i", "<c-s>", "<ESC>:w<CR>")

-- Basic
vim.keymap.set("n", "<c-a>", "ggVG")
-- silent so that you don't get popup messages!
vim.api.nvim_set_keymap('n', '<c-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "ZZ", ":wqa!<CR>")
vim.keymap.set({ "n", "v" }, "<c-j>", "10j")
vim.keymap.set({ "n", "v" }, "<c-k>", "10k")
vim.keymap.set({ "n", "v" }, "<c-h>", "b")
vim.keymap.set({ "n", "v" }, "<c-l>", "w")
vim.keymap.set("n", "tl", "<cmd>silent :bn<CR>")
vim.keymap.set("n", "th", "<cmd>silent :bp<CR>")
vim.keymap.set("n", "tn", "<cmd>silent :enew<CR>")
vim.keymap.set("n", "td", "<cmd>silent :bd!<cr>", { desc = "Remove buffer" })
vim.keymap.set("n", "tp", "<c-^><cr>", { desc = "Go to previously opened buffer" })
vim.keymap.set("n", "<leader>n", "<cmd>silent :noh<CR>", { desc = "Toggle nohighlight" })
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Jump to start of line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "Jump to end of line" })

-- Paste but don't overwrite copy-register
vim.keymap.set("v", "p", '"_dP')

-- Make Y behave like C and D
vim.keymap.set("n", "Y", "y$")

-- Remaps for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- In terminal mode, map <Esc> to go to normal-mode in the terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Comment (built-in gc operator remapped to cc)
vim.keymap.set({ "n", "x", "o" }, "cc", "gc", { remap = true, desc = "Line comment" })

return {}
