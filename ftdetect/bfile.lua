vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.b" },
    group = vim.api.nvim_create_augroup('qtechng-bfile', { clear = true }),
    command = "set filetype=bfile"
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "bfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
