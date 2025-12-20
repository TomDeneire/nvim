PROJECT_DIR = "/home/tdeneire/Dropbox/code"

-- Find in current directory
vim.keymap.set("n", "ff", function()
    Snacks.picker.grep({
        ignored = true,
        hidden = true,
    })
end, { desc = "Directory grep" })

-- Find in projects
vim.keymap.set("n", "<c-f>", function()
    Snacks.picker.grep({
        ignored = true,
        hidden = true,
        cwd = PROJECT_DIR,
    })
end, { desc = "Project grep" })

-- Files in current directory
vim.keymap.set("n", "ts", function()
    Snacks.picker.files({
        ignored = true,
        hidden = true,
    })
end, { desc = "Files in current directory" })

-- Files in project directory
vim.keymap.set("n", "<c-p>", function()
    Snacks.picker.files({
        ignored = true,
        hidden = true,
        cwd = PROJECT_DIR,
    })
end, { desc = "Find Config File" })

-- Recent files
vim.keymap.set("n", "<leader>old", function()
    Snacks.picker.recent({
        ignored = true,
        hidden = true,
    })
end, { desc = "Find recent files" })

-- Buffers
vim.keymap.set("n", "tb", function()
    Snacks.picker.buffers({
    })
end, { desc = "Show buffers" })

-- Buffers
vim.keymap.set("n", "<leader>lg", function()
    Snacks.lazygit({
    })
end, { desc = "Open LazyGit" })

-- Undo tree
vim.keymap.set("n", "<leader>u", function()
    Snacks.picker.undo({
    })
end, { desc = "Undo tree" })

-- Pickers
vim.keymap.set("n", "<leader>p", function()
    Snacks.picker.pickers({
    })
end, { desc = "Show pickers" })

return {}
