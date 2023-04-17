-- Globals
LSP_files = { "*.lua", "*.go", "*.js", "*.xml", "*.html", "*.md", "*.json", "*.ts", "*.rst", "*.vim" }
QtechNG_files = { "*.m", "*.l", "*.x", "*.i", "*.b", "*.d" }

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Trim trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { ".md", "*.vim", "*.py", "*.lua", "*.go", "*.js", "*.x", "*.rst" },
    command = "silent! lua Trim_trailing_whitespace()",
})

-- -- Autoformat
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = LSP_files,
    command = "silent! lua vim.lsp.buf.format()",
})

-- Code action
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.js" },
    command = "silent! lua vim.lsp.buf.code_action()",
})

-- Qtechng file format
vim.api.nvim_create_autocmd("BufwritePost", {
    pattern = QtechNG_files,
    command = "silent! !qtechng file format --inplace %:p",
})

-- MUMPS
vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[inoremap <buffer> <TAB> .]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[inoremap <buffer> <c-l> s nr=""<CR>f  s nr=$O(x(nr)) q:nr=""  d]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[inoremap <buffer> <CR> <ESC>:lua MumpsIndent()<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[setlocal expandtab shiftwidth=1 softtabstop=1 nowrap]]
})

return {}
