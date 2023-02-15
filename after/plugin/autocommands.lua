if vim.g.vscode then
    return
end

-- Globals
LSP_files = { "*.py", "*.lua", "*.go", "*.js", "*.xml", "*.html", "*.json" }
QtechNG_files = { "*.m", "*.l", "*.x", "*.i", "*.b", "*.d" }

-- LSP diagnostics in notify
vim.api.nvim_create_autocmd("BufEnter", {
    command = "silent! lua Diagnostics()",
})
vim.api.nvim_create_autocmd("BufWritePre", {
    command = "silent! lua Diagnostics()",
})
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "silent! lua Diagnostics()",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
})

-- Trim trailing whitespace
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.vim", "*.py", "*.lua", "*.go", "*.js", "*.x" },
    command = "silent! lua Trim_trailing_whitespace()",
})

-- Autoformat
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = LSP_files,
    command = "silent! lua vim.lsp.buf.format()",
})

-- Code action
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.go", "*.js" },
    command = "silent! lua vim.lsp.buf.code_action()",
})

-- Qtechng file format
vim.api.nvim_create_autocmd("BufWritePost", {
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
