vim.g.mapleader = ' '

-- nnoremap <silent> <c-i> :lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent> <c-s> :w<CR>
-- inoremap <silent> <c-s> <Esc> :w<CR>
-- nnoremap <c-v> "*p
-- inoremap <c-v> <Esc>"*pa
-- vnoremap <c-c> "+y
-- nnoremap <c-j> 10j
-- nnoremap <c-k> 10k
-- vnoremap <c-j> 10j
-- vnoremap <c-k> 10k
-- nnoremap <F5> :UndotreeToggle<CR>
-- nnoremap <c-[> <c-^>
-- nnoremap <leader>all :tab ba<CR> :NvimTreeToggle<CR>
-- nnoremap <leader>flake :cexpr system("flake8 " . shellescape(expand("%")))<CR> :copen<CR>

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<c-a>", "ggVG")
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
