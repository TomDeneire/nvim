---@diagnostic disable: undefined-global
function Split(mystring, delim)
    local t = {}
    for str in string.gmatch(mystring, "([^" .. delim .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function JumpToRou()
    --"d %CSV^ucsvsbld($file,$exec,$delimiter,$mode,$encoding,$fieldnames)»
    --"«s $error=$$%ChckTyp^barsrou($type,$context,$user)»"
    local mroutine = vim.fn.expand("<cWORD>")
    local m = Split(mroutine, "(")
    mroutine = m[1]
    local t = Split(mroutine, "^")
    local mlabel = t[1]
    local l = Split(mlabel, "$$")
    if l[2] ~= nil then
        mlabel = l[2]
    end
    local mfile = t[2]
    local jumpcmd = "echo $(qtechng registry get qtechng-work-dir)$(qtechng registry get os-sep)$(jq -r '." ..
        '"' ..
        mfile ..
        '.m"' ..
        "' $(qtechng registry get qtechng-support-dir)/m_unique_map.json)$(qtechng registry get os-sep)" ..
        mfile .. ".m"
    local resultfile = vim.fn.system(jumpcmd)
    local cmd = "tabnew +/" .. mlabel .. " " .. resultfile
    vim.cmd(cmd)
end

function DefineMacro()
    -- m4_getCensorType
    local macro_name = vim.fn.expand("<cword>")
    local macro_find = "echo $(qtechng registry get qtechng-work-dir)$(qtechng object list " ..
        macro_name .. " --jsonpath='$..DATA..source' --unquote)"
    local macro_file = vim.fn.system(macro_find)
    local t = Split(macro_name, "m4_")
    local macro_def = t[1]
    local cmd = "tabnew +/" .. macro_def .. " " .. macro_file
    vim.cmd(cmd)
end

function SourceList()
    local pattern = vim.fn.input("Search QtechNG repository = ", "")
    local listcmd = "qtechng source list --jsonpath=$..DATA..fileurl --needle=" ..
        pattern .. " | awk -F 'file://' '{print $2}' | awk -F '\"' '{print $1}'"
    local result = vim.fn.system(listcmd)
    local t = {}
    for str in string.gmatch(result, "([^" .. "\n" .. "]+)") do
        local file = {}
        file["filename"] = str
        file["pattern"] = pattern
        table.insert(t, file)
    end
    if next(t) then
        vim.fn.setqflist({}, " ", {
            items = t
        })
        require("telescope.builtin").quickfix({ fname_width = 100 })
    end
end

function OpenInGit()
    local cmd = "!export CURRENT_FILE=%:p && export URL=$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..vcurl' --unquote) && google-chrome-stable $URL"
    vim.cmd(cmd)
end

function ComparePrevious()
    local cmd = "!export CURRENT_FILE=%:p && export QPATH=$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..qpath' --unquote) && export PREVIOUS=$(qtechng registry get qtechng-releases | awk '{print $(NF-1)}') && mkdir -p $PREVIOUS && cd $PREVIOUS && qtechng source co $QPATH --version=$PREVIOUS && meld $PREVIOUS/$(qtechng file tell $CURRENT_FILE --jsonpath='$..DATA..relpath' --unquote) $CURRENT_FILE"
    vim.cmd(cmd)
end
