-- (source editorconfig.nvim)
function Trim_trailing_whitespace()
    local view = vim.fn.winsaveview()
    vim.api.nvim_command("silent! undojoin")
    vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
    return vim.fn.winrestview(view)
end

-- "functions
-- function FindInWorkSpace()
--   let workspace = getcwd()
--   if (matchstr(workspace, "/brocade/source/data")) == ""
--      :lua require("telescope.builtin").find_files({hidden=true, find_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/code"})
--   else
--      :lua require("telescope.builtin").find_files({hidden=true, find_command={"rg","--smart-case","--files"}, no_ignore=true, no_ignore_parent=true, cwd="/home/tdeneire/projects/brocade/source/data"})
--   endif
-- endfunction

function FindInWorkSpace2()
    local workspace = "a"
end
