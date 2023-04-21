-- (source editorconfig.nvim)
function Trim_trailing_whitespace()
    local view = vim.fn.winsaveview()
    vim.api.nvim_command("silent! undojoin")
    vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
    return vim.fn.winrestview(view)
end

function RestoreSession()
    vim.api.nvim_command("NoNeckPain")
    vim.api.nvim_command("lua require('persistence').load({ last = true })")
    vim.api.nvim_command("NoNeckPain")
end

return {}
