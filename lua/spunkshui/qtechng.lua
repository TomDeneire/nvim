---@diagnostic disable: undefined-global
function JumpToRou()
    local mroutine = vim.g.mrou
    local t = {}
    for str in string.gmatch(mroutine, "([^" .. "^" .. "]+)") do
        table.insert(t, str)
    end
    local l = {}
    local mlabel = t[1]
    for str in string.gmatch(mlabel, "([^" .. "$$" .. "]+)") do
        table.insert(l, str)
    end
    if l[2] ~= nil then
        mlabel = l[2]
    end
    vim.g.mlabel = mlabel
    local mfile = t[2]
    vim.g.jumpexe = "echo $(qtechng registry get qtechng-work-dir)$(qtechng registry get os-sep)$(jq -r '." ..
        '"' ..
        mfile ..
        '.m"' ..
        "' $(qtechng registry get qtechng-support-dir)/m_unique_map.json)$(qtechng registry get os-sep)" ..
        mfile .. ".m"
end

-- doesn't work yet
function DefineMacro()
    local macro_name = vim.fn.expand("<cword>")
    local macro_find = "echo $(qtechng registry get qtechng-work-dir)$(qtechng object list " ..
        macro_name .. " --jsonpath='$..DATA..source' --unquote)"
    local macro_file = vim.fn.system(macro_find)
    local t = {}
    for str in string.gmatch(macro_name, "([^" .. "m4_" .. "]+)") do
        table.insert(t, str)
    end
    local macro_def = t[1]
    local macro_open = "+/" .. macro_def .. " " .. macro_file
    local cmd = ":execute 'tabnew' " .. macro_open
    vim.cmd(cmd)
end

function SourceList()
    local pattern = vim.fn.input("Search string = ", "")
    local cmd = ':cexpr system("qtechng source list --jsonpath=$..DATA..fileurl --needle=' ..
        pattern .. '")'
    vim.cmd(cmd)
    local opencmd = ":copen"
    vim.cmd(opencmd)
end
