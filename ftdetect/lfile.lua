vim.filetype.add({ extension = { l = "lfile" } })


vim.api.nvim_create_autocmd("FileType", {
    pattern = "lfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
