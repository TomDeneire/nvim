vim.filetype.add({ extension = { d = "dfile" } })


vim.api.nvim_create_autocmd("FileType", {
    pattern = "dfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
