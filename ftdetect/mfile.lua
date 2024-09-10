vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.m" },
    group = vim.api.nvim_create_augroup('qtechng-mfile', { clear = true }),
    command = "set filetype=mfile"
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "mfile",
    command = [[setlocal wrap]]
})
