vim.keymap.set(
    "n",
    "<c-b>",
    require("modules.qtechng").checkin_current_file,
    { desc = "QtechNG: checkin current file" }
)
vim.keymap.set("n", "<c-o>", ":!qtechng file refresh<CR>", { desc = "QtechNG: refresh directory" })
vim.keymap.set("n", "<leader>rou", require("modules.qtechng").jump_to_routine, { desc = "QtechNG: jump to M routine" })
vim.keymap.set(
    "n",
    "<c-m>",
    require("modules.qtechng").jump_to_macro_definition,
    { desc = "QtechNG: jump to macro definition" }
)
vim.keymap.set(
    "n",
    "<leader>qg",
    require("modules.qtechng").open_in_git_browser,
    { desc = "QtechNG: open in cgit web interface" }
)
vim.keymap.set("n", "<leader>qp", require("modules.qtechng").compare_previous, { desc = "QtechNG: compare previous" })
vim.keymap.set("n", "<leader>qs", require("modules.qtechng").source_list, { desc = "QtechNG: source list" })
vim.keymap.set("n", "<leader>qm", require("modules.qtechng").macro_list, { desc = "QtechNG: show macro list" })
vim.keymap.set("v", "<leader>qi", ":norm xi .<CR>", { desc = "QtechNG: M indent" })
vim.keymap.set(
    "n",
    "<leader>qn",
    require("modules.qtechng").new_var,
    { desc = "QtechNG: new M variable" }
)
vim.keymap.set(
    "n",
    "<leader>ql",
    [[<cmd>silent :cexpr system("qtechng file list --changed --cwd=$(qtechng registry get qtechng-work-dir) --recurse | jq -r .DATA[].fileurl | sed 's/$/:0:0/'")<CR>:copen<cr>]],
    { desc = "QtechNG: show changed files" }
)

return {}
