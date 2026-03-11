-- Set up abbreviations eagerly so :h/:help always trigger FloatingHelp
local function cmd_abbrev(abbrev, expansion)
    local cmd = 'cabbr ' ..
        abbrev ..
        ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "' .. expansion .. '" : "' .. abbrev .. '")<CR>'
    vim.cmd(cmd)
end

cmd_abbrev('h', 'FloatingHelp')
cmd_abbrev('help', 'FloatingHelp')
cmd_abbrev('helpc', 'FloatingHelpClose')
cmd_abbrev('helpclose', 'FloatingHelpClose')

return {
    'Tyler-Barham/floating-help.nvim',
    cmd = { "FloatingHelp", "FloatingHelpClose" },
    opts = {
        width = 80,
        height = 0.9,
        position = 'C',
    },
}
