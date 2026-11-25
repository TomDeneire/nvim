vim.filetype.add({ extension = { b = "bfile" } })


vim.api.nvim_create_autocmd("FileType", {
    pattern = "bfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
