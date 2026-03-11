vim.keymap.set(
    "n",
    "<leader>s",
    function() require('persistence').load() end,
    { desc = "Restore previous session files" }
)

return {}
