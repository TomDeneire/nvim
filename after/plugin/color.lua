if not vim.g.vscode
then
    vim.cmd("syntax on")
    vim.g.spunkshui_next_terminal_bold = 1
    vim.g.spunkshui_next_terminal_italic = 1
    vim.cmd.colorscheme("spunkshui")
    -- removes tildes
    vim.cmd("highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg")
end
