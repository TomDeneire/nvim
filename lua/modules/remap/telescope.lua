-- Telescope remaps

vim.keymap.set("n", "tt", "<cmd>silent :Telescope file_browser<CR>", { desc = "Open Telescope File Browser" })

vim.keymap.set("n", "ff", require("telescope.builtin").live_grep, { desc = "Telescope live grep in current directory" })

vim.keymap.set("n", "<leader>old", require("telescope.builtin").oldfiles, { desc = "Telescope list of recent files" })

vim.keymap.set("n", "<leader>map", require("telescope.builtin").keymaps, { desc = "Show keymaps" })

vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Undotree" })

return {}
