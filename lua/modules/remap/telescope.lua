vim.keymap.set("n", "tt", "<cmd>silent :Telescope file_browser<CR>", { desc = "Open Telescope File Browser" })

vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Undotree" })

return {}
