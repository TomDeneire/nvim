vim.keymap.set(
    "n",
    "<leader>s",
    require('persistence').load,
    { desc = "Restore previous session files" }
)

return {}
