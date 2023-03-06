if vim.g.vscode then
    return
end

return {
    "dstein64/vim-startuptime",
    lazy = true,
    cmd = "StartupTime",
    config = function()
        vim.g.startuptime_tries = 10
    end,
}
