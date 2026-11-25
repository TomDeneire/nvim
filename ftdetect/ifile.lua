vim.filetype.add({ extension = { i = "ifile" } })


vim.api.nvim_create_autocmd("FileType", {
    pattern = "ifile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
