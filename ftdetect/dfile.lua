vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.d" },
    group = vim.api.nvim_create_augroup('qtechng-dfile', { clear = true }),
    command = "set filetype=dfile"
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "dfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
