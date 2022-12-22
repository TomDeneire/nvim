if vim.g.vscode then
    return
end

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
        pattern = { "*.py", "*.lua", "*.go", "*.js", "*.xml", ".html", ".json" },
        command = "silent! lua vim.lsp.buf.format()",
    })

    -- Code action
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.go", "*.js" },
        command = "silent! lua vim.lsp.buf.code_action()",
    })

    -- Qtechng file format
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.m", "*.l", "*.x", "*.i", "*.b", ".d" },
        command = "silent! !qtechng file format --inplace %:p",
    })

    -- MUMPS
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "mumps",
        command = [[inoremap <buffer> <TAB> .]]
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "mumps",
        command = [[inoremap <buffer> <c-l> s nr=""<CR>f  s nr=$O(x(nr)) q:nr=""  d]]
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "mumps",
        command = [[inoremap <buffer> <CR> <ESC>:lua MumpsIndent()<CR>]]
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "mumps",
        command = [[setlocal expandtab shiftwidth=1 softtabstop=1 nowrap]]
    })
