vim.filetype.add({ extension = { x = "xfile" } })


vim.api.nvim_create_autocmd("FileType", {
    pattern = "xfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4 commentstring=//%s]]
})
