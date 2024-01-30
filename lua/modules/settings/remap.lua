-- Basic
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<c-a>", "ggVG")
vim.keymap.set("n", "<c-s>", ":w<CR>")
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
vim.keymap.set({ "n", "x", "o" }, "L", "$", { desc = "Jump to end of line" })
vim.keymap.set({ "n", "x", "o" }, "J", "<c-i>", { desc = "Jump to start of line" })
vim.keymap.set({ "n", "x", "o" }, "K", "<c-o>", { desc = "Jump to end of line" })
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

-- Specific plugins
vim.keymap.set(
    "n",
    "<leader>lg",
    "<cmd>lua require('lazy.util').float_term('lazygit',{size = {width = 0.9, height = 0.9}})<cr>",
    { desc = "Open LazyGit" }
)
vim.keymap.set("n", "tt", "<cmd>silent :Telescope file_browser<CR>", { desc = "Open Telescope File Browser" })
vim.keymap.set("n", "ff", require("telescope.builtin").live_grep, { desc = "Telescope live grep in current directory" })
vim.keymap.set("n", "<leader>old", require("telescope.builtin").oldfiles, { desc = "Telescope list of recent files" })
vim.keymap.set(
    "n",
    "<leader>s",
    require("modules.utils").restore_session,
    { desc = "Restore previous session files" }
)
vim.keymap.set("n", "<leader>map", require("telescope.builtin").keymaps, { desc = "Show keymaps" })

-- QtechNG functions
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
vim.keymap.set(
    "n",
    "<leader>black",
    "<cmd>silent :!black %:p --config=/home/tdeneire/.config/black/pyproject.toml<CR>",
    { desc = "Format with Black" }
)

return {}
