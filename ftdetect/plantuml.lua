vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.uml", "*.puml" },
    group = vim.api.nvim_create_augroup('spunkshui-plantuml', { clear = true }),
    command = "set filetype=plantuml"
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "plantuml",
    command = [[setlocal expandtab shiftwidth=4 softtabstop=4]]
})
