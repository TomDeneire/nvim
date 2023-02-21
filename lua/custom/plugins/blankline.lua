if vim.g.vscode then
    return
end

-- Indent blankline
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}

return {}
