if not vim.g.vscode
then
    vim.cmd("syntax on")
    vim.cmd.colorscheme("spunkshui")
    -- removes tildes
    vim.cmd("highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg")
end
