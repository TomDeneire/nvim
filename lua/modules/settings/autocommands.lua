-- Globals

QtechNG_files = { "*.m", "*.l", "*.x", "*.i", "*.b", "*.d" }

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('spunkshui-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Trim trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { ".md", "*.vim", "*.py", "*.lua", "*.go", "*.js", "*.x", "*.rst" },
    callback = require("modules.utils").trim_trailing_whitespace,
})

-- Code action
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.hs" },
    command = "silent! lua vim.lsp.buf.code_action()",
})

-- Qtechng file format
vim.api.nvim_create_autocmd("BufwritePost", {
    pattern = QtechNG_files,
    command = "silent! !qtechng file format --inplace %:p",
})

-- Auto-add path to zoxide
vim.api.nvim_create_autocmd("BufNew", {
    desc = 'Auto-add path to zoxide',
    command = "silent! !zoxide add %:p:h",
})

-- MUMPS
vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[inoremap <buffer> <TAB> .]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[noremap <buffer> <c-l> <ESC>:lua require('modules.qtechng').loop_vars()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[inoremap <buffer> <CR> <ESC>:lua require('modules.qtechng').mumps_indent()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "mfile", "xfile" },
    command = [[noremap <buffer> <C-i> <ESC>:lua require('modules.qtechng').show_macro()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "bfile",
    command = [[noremap <buffer> <C-l> <ESC>:lua require('modules.qtechng').generate_lgcode()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[setlocal expandtab shiftwidth=1 softtabstop=1 nowrap]]
})

return {}
