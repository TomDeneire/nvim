vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.x" },
    group = vim.api.nvim_create_augroup('qtechng-xfile', { clear = true }),
    command = "set filetype=xfile"
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "xfile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
