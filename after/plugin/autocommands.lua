if not vim.g.vscode
then

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

end
