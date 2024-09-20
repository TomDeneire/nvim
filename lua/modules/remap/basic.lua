-- Basic
vim.keymap.set("n", "<leader>m", "q", { desc = "Record macro" })
vim.keymap.set("n", "<c-a>", "ggVG")
vim.keymap.set("n", "<c-s>", ":w<CR>")
vim.keymap.set("n", "ZZ", ":wqa!<CR>")
vim.keymap.set({ "n", "v" }, "<c-j>", "10j")
vim.keymap.set({ "n", "v" }, "<c-k>", "10k")
vim.keymap.set({ "n", "v" }, "<c-h>", "b")
vim.keymap.set({ "n", "v" }, "<c-l>", "w")
vim.keymap.set("n", "tl", "<cmd>silent :bn<CR>")
vim.keymap.set("n", "th", "<cmd>silent :bp<CR>")
vim.keymap.set("n", "tn", "<cmd>silent :enew<CR>")
vim.keymap.set("n", "td", "<cmd>silent :bd!<cr>", { desc = "Remove buffer" })
vim.keymap.set("n", "tb", require("telescope.builtin").buffers, { desc = "Show buffers" })
vim.keymap.set("n", "tp", "<c-^><cr>", { desc = "Go to previously opened buffer" })
vim.keymap.set("n", "<leader>n", "<cmd>silent :noh<CR>", { desc = "Toggle nohighlight" })
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Jump to start of line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "Jump to end of line" })
vim.keymap.set({ "n", "x", "o" }, "J", "<c-i>", { desc = "Jump to start of line" })
vim.keymap.set({ "n", "x", "o" }, "K", "<c-o>", { desc = "Jump to end of line" })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
        layout_config = { width = 0.7 }
    })
end, { desc = '[/] Fuzzily search in current buffer' })
-- Paste but don't overwrite copy-register
vim.keymap.set("v", "p", '"_dP')
-- Make Y behave like C and D
vim.keymap.set("n", "Y", "y$")

-- Terminal
vim.keymap.set(
    "n",
    "<leader>term",
    "<cmd>lua require('lazy.util').float_term('bash',{})<cr>",
    { desc = "Open terminal" }
)

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


return {}
