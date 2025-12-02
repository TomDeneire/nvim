-- Specific utilities
vim.keymap.set(
    "n",
    "<leader>lg",
    "<cmd>lua require('lazy.util').float_term('lg',{size = {width = 1, height = 1}})<cr>",
    { desc = "Open LazyGit" }
)

vim.keymap.set(
    "n",
    "<leader>s",
    require("modules.utils").restore_session,
    { desc = "Restore previous session files" }
)

-- Other functions
vim.keymap.set("n", "<c-p>", require("modules.utils").find_in_workspace, { desc = "Find in current workspace" })

vim.keymap.set("n", "<c-f>", require("modules.utils").grep_in_workspace, { desc = "Grep in current workspace" })

vim.keymap.set(
    "v",
    "<leader>s",
    "y :lua require('modules.utils').grep_yanked()<CR>",
    { desc = "Yank and grep in current workspace" }
)

vim.keymap.set("n", "<leader>grep", require("modules.utils").grep_pattern, { desc = "Grep in files with pattern" })

vim.keymap.set(
    "n",
    "<leader>flake",
    ':cexpr system("flake8 " . shellescape(expand("%")))<CR> :copen<CR>',
    { desc = "Flake8" }
)


return {}
