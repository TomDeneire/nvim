-- Create default mappings
vim.g.NERDCreateDefaultMappings = 0
-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1
-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1
-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'
-- Set a language to use its alternate delimiters by default
vim.g.NERDAltDelims_java = 1
-- Add your own custom formats or override the defaults
local delims = {}
local mfile = {}
mfile["left"] = ";"
mfile["right"] = ""
delims["mfile"] = mfile
local xfile = {}
xfile["left"] = "//"
xfile["right"] = ""
delims["xfile"] = xfile
vim.g.NERDCustomDelimiters = delims
-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1
-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = 1
-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = 1

return {}
