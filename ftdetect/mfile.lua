vim.filetype.add({ extension = { m = "mfile" } })


vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[setlocal wrap commentstring=;%s]]
})
