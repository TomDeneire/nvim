-- Telescope specific functions

local function getfinddir()
    local workspace = vim.fn.getcwd()
    local sourcedir = "/brocade/source/data"
    local packagesdir = "/brocade/packages"
    local qtechng_work_dir = "/home/tdeneire/projects/brocade/source/data"
    local packages_work_dir = "/home/tdeneire/projects/brocade/packages"
    local projects_work_dir = "/home/tdeneire/projects/code"
    local websites_work_dir = "/home/tdeneire/Dropbox/websites"
    if string.find(workspace, sourcedir) ~= nil then
        return qtechng_work_dir
    elseif string.find(workspace, packagesdir) ~= nil then
        return packages_work_dir
    elseif string.find(workspace, websites_work_dir) ~= nil then
        return websites_work_dir
    else
        return projects_work_dir
    end
end

function FindInWorkSpace()
    local find_dir = getfinddir()
    require("telescope.builtin").find_files(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = find_dir
        })
end

function GrepInWorkSpace()
    local find_dir = getfinddir()
    require("telescope.builtin").live_grep(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = find_dir
        })
end

function GrepYanked()
    local text = vim.fn.getreg("")
    text = string.lower(text)
    local find_dir = getfinddir()
    require("telescope.builtin").grep_string(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = find_dir,
            search = text
        })
end

function GrepPattern()
    local find_dir = getfinddir()
    local pattern = vim.fn.input("Grep_pattern=", "*.")
    require("telescope.builtin").live_grep(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = find_dir,
            glob_pattern = pattern
        })
end

return {}
