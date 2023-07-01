-- Basic
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<c-a>", "ggVG")
vim.keymap.set("n", "<c-s>", ":w<CR>")
vim.keymap.set("n", "<c-j>", "10j")
vim.keymap.set("v", "<c-j>", "10j")
vim.keymap.set("n", "<c-k>", "10k")
vim.keymap.set("v", "<c-k>", "10k")
vim.keymap.set("n", "tl", "<cmd>silent :bn<CR>")
vim.keymap.set("n", "th", "<cmd>silent :bp<CR>")
vim.keymap.set("n", "tn", "<cmd>silent :enew<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>silent :noh<CR>", { desc = 'Toggle nohighlight' })

-- Terminal
vim.keymap.set("n", "<leader>term", "<cmd>lua require('lazy.util').float_term('bash',{})<cr>", { desc = 'Open terminal' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Specific plugins
vim.keymap.set("n", "<leader>lg", "<cmd>lua require('lazy.util').float_term('lazygit',{})<cr>", { desc = 'Open LazyGit' })
vim.keymap.set("n", "tt", "<cmd>silent :Telescope file_browser<CR>", { desc = 'Open Telescope File Browser' })
vim.keymap.set("n", "ff", require('telescope.builtin').live_grep, { desc = 'Telescope live grep in current direcotry' })
vim.keymap.set("n", "<leader>old", require('telescope.builtin').oldfiles, { desc = 'Telescope list of recent files' })
vim.keymap.set("n", "<leader>ses", "<cmd>lua RestoreSession()<cr>", { desc = 'Restore previous session files' })

-- QtechNG functions (to do: refactor Lua functions to local functions like below)
vim.keymap.set("n", "<c-b>", ":!qtechng file ci<CR>", { desc = 'QtechNG: checkin directory' })
vim.keymap.set("n", "<c-o>", ":!qtechng file refresh<CR>", { desc = 'QtechNG: refresh directory' })
vim.keymap.set("n", "<leader>rou", "<cmd>silent lua JumpToRou()<CR>", { desc = 'QtechNG: jump to M routine' })
vim.keymap.set("n", "<c-m>", "<cmd>silent lua DefineMacro()<CR>", { desc = 'QtechNG: jump to macro definition' })
vim.keymap.set("n", "<leader>qg", "<cmd>silent lua OpenInGit()<CR>", { desc = 'QtechNG: open in cgit web interface' })
vim.keymap.set("n", "<leader>qp", "<cmd>silent lua ComparePrevious()<CR>", { desc = 'QtechNG: compare previous' })
vim.keymap.set("n", "<leader>qs", "<cmd>lua SourceList()<CR>", { desc = 'QtechNG: source list' })
vim.keymap.set("n", "<leader>qm", "<cmd>lua MacroList()<CR>", { desc = 'QtechNG: show macro list' })
vim.keymap.set("v", "<leader>qi", ":norm xi .<CR>", { desc = 'QtechNG: M indent' })
vim.keymap.set("n", "<leader>qn", "mnviwy?^ n <CR>A,<ESC>pviwy`n<cmd>silent :noh<CR>",
    { desc = 'QtechNG: new M variable' })
vim.keymap.set("n", "<leader>ql",
    ":!qtechng file list --changed --cwd=$(qtechng registry get qtechng-work-dir) --recurse | jq -r .DATA[0].qpath<CR>",
    { desc = 'QtechNG: show changed files' })

-- Other functions
vim.keymap.set("n", "<c-p>", "<cmd>silent lua Find_in_workspace()<CR>", { desc = 'Find in current workspace' })
vim.keymap.set("n", "<c-f>", "<cmd>silent lua Grep_in_workspace()<CR>", { desc = 'Grep in current workspace' })
vim.keymap.set("v", "<leader>s", "y :lua Grep_yanked()<CR>", { desc = 'Yank and grep in current workspace' })
vim.keymap.set("n", "<leader>grep", "<cmd>silent lua Grep_pattern()<CR>", { desc = 'Grep in files with pattern' })
vim.keymap.set("n", "<leader>flake", ':cexpr system("flake8 " . shellescape(expand("%")))<CR> :copen<CR>',
    { desc = 'Flake8' })
vim.keymap.set("n", "<leader>black", "<cmd>silent :!black %:p --config=/home/tdeneire/.config/black/pyproject.toml<CR>",
    { desc = 'Format with Black' })

return {}
