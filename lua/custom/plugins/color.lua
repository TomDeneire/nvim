if vim.g.vscode then
    return
end

vim.g.spunkshui_next_terminal_bold = 1
vim.g.spunkshui_next_terminal_italic = 1
vim.cmd.colorscheme("spunkshui")
vim.g.syntax_on = 1

-- removes tildes
vim.cmd("highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg")

return {}
