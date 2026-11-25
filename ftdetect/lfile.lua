vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.l" },
    group = vim.api.nvim_create_augroup('qtechng-lfile', { clear = true }),
    command = "set filetype=lfile"
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "lfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
