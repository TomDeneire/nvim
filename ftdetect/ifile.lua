vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.i" },
    group = vim.api.nvim_create_augroup('qtechng-ifile', { clear = true }),
    command = "set filetype=ifile"
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "ifile",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
