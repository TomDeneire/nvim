---@diagnostic disable: undefined-global

--REGISTRY GLOBALS

OS_SEP = "$(qtechng registry get os-sep)"
WORK_DIR = "$(qtechng registry get qtechng-work-dir)"
SUPPORT_DIR = "$(qtechng registry get qtechng-support-dir)"

-- FUNCTIONS

function Split2(mystring, delim)
    -- to do: pattern matcht ook op single "m"! (zie vb. 2)
    local t = {}
    for str in string.gmatch(mystring, "([^" .. delim .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function Split(mystring, delim)
    -- to do: rigourous testing
    -- before you can promote to general split!

    local result = {}
    local start = 1

    while (true) do
        local _, pos = string.find(mystring, delim, start, true)
        if pos == nil then
            local rest = string.sub(mystring, start, string.len(mystring))
            table.insert(result, rest)
            break
        else
            local matchlen = pos - string.len(delim)
            local part = string.sub(mystring, start, matchlen)
            start = pos + 1
            table.insert(result, part)
        end
    end

    return result
end

function RStrip(mystring, delim)
    local length = string.len(mystring)
    local minus_one = string.sub(mystring, 1, length - 1)
    if minus_one .. delim == mystring then
        return RStrip(minus_one, delim)
    else
        return mystring
    end
end

function Length(mytable)
    local length = 0
    for _ in pairs(mytable) do
        length = length + 1
    end
    return length
end

function JumpToRou()
    --"d %CSV^ucsvsbld($file,$exec,$delimiter,$mode,$encoding,$fieldnames)»
    --"«s $error=$$%ChckTyp^barsrou($type,$context,$user)»"
    -- action = "d %Lst^blicjapi"
    local mroutine = vim.fn.expand("<cWORD>")
    mroutine = string.gsub(mroutine, "'", "")
    mroutine = string.gsub(mroutine, '"', "")
    mroutine = string.gsub(mroutine, 'm4_Routine.', "")
    mroutine = RStrip(mroutine, ")")
    local m = Split(mroutine, "(")
    mroutine = m[1]
    local t = Split(mroutine, "^")
    local mlabel = t[1]
    local l = Split(mlabel, "$$")
    if l[2] ~= nil then
        mlabel = l[2]
    end
    local mfile = t[2] .. ".m"
    local jumpcmd = "echo "
    jumpcmd = jumpcmd .. WORK_DIR
    jumpcmd = jumpcmd .. OS_SEP
    jumpcmd = jumpcmd .. "$(jq -r '." .. '"' .. mfile .. '"' .. "' "
    jumpcmd = jumpcmd .. SUPPORT_DIR .. OS_SEP .. "m_unique_map.json)"
    jumpcmd = jumpcmd .. OS_SEP .. mfile
    local resultfile = vim.fn.system(jumpcmd)
    local cmd = "e +/" .. mlabel .. " " .. resultfile
    vim.cmd(cmd)
end

function DefineMacro()
    -- m4_getCensorType(type,loi)
    -- m4_documentElementInputDate()
    -- m4_zever
    local wordUnderCursor = vim.fn.expand("<cword>")
    if string.find(wordUnderCursor, "m4_") == nil then
        return
    end
    local t = Split(wordUnderCursor, "m4_")
    local macro_name = t[2]
    local macrocmd = "echo "
    macrocmd = macrocmd .. WORK_DIR
    macrocmd = macrocmd .. "$(jq -r ." .. '"' .. macro_name .. '" '
    macrocmd = macrocmd .. SUPPORT_DIR .. OS_SEP .. "m4_map.json)"
    local macro_file = vim.fn.system(macrocmd)
    local macro_file_len = string.len(macro_file)
    local exists = string.sub(macro_file, macro_file_len - 4, macro_file_len)
    exists = string.gsub(exists, "\n", "")
    if exists == "null" then
        return
    end
    local cmd = "e +/" .. macro_name .. "( " .. macro_file
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

function MacroList()
    require("telescope.builtin").find_files(
        {
            hidden = true,
            find_command = { "rg", "--smart-case", "--files" },
            no_ignore = true,
            no_ignore_parent = true,
            cwd = "/home/tdeneire/Dropbox/brocade/support/macros"
        })
end

function OpenInGit()
    local current_file = vim.fn.expand("%:p")
    local gitcmd = "sensible-browser $(qtechng file tell " .. current_file
    gitcmd = gitcmd .. " --jsonpath='$..DATA..vcurl' --unquote)"
    io.popen(gitcmd)
end

function ComparePrevious()
    local current_file = vim.fn.expand("%:p")
    local cmd = "export QPATH=$(qtechng file tell " .. current_file
    cmd = cmd .. " --jsonpath='$..DATA..qpath' --unquote) "
    cmd = cmd .. "&& export PREVIOUS=$(qtechng registry get qtechng-releases "
    cmd = cmd .. "| awk '{print $(NF-1)}') "
    cmd = cmd .. "&& mkdir -p $PREVIOUS && cd $PREVIOUS && "
    cmd = cmd .. "qtechng source co $QPATH --version=$PREVIOUS "
    cmd = cmd .. "&& meld $PREVIOUS/$(qtechng file tell " .. current_file
    cmd = cmd .. " --jsonpath='$..DATA..relpath' --unquote) "
    cmd = cmd .. current_file
    io.popen(cmd)
end

function MumpsIndent()
    local linepos = vim.fn.getcurpos()
    local posinline = linepos[3]
    local current_line = vim.fn.getline(".")
    local linelength = string.len(current_line)
    if posinline == linelength then
        -- cursor at end of the line
        local wordUnderCursor = vim.fn.expand("<cword>")
        local indent_level = Split(current_line, " ")
        local indent_begin = indent_level[2]
        local indent = ""
        if indent_begin ~= nil then
            if (wordUnderCursor == "d") or (wordUnderCursor == "q") then
                if wordUnderCursor == "d" then
                    if string.sub(indent_begin, 1, 1) == "." then
                        indent = " " .. indent_begin .. ". "
                    else
                        indent = " . "
                    end
                else
                    if string.sub(indent_begin, 1, 1) == "." then
                        local indent_minus_one = string.len(indent_begin) - 1
                        print(indent_minus_one)
                        if indent_minus_one < 1 then
                            indent = " "
                        else
                            indent = " " .. string.sub(indent_begin, 1, indent_minus_one) .. " "
                        end
                    else
                        indent = " "
                    end
                end
            else
                if string.sub(indent_begin, 1, 1) == "." then
                    indent = " " .. indent_begin .. " "
                else
                    indent = " "
                end
            end
        end
        local line = vim.fn.line(".")
        vim.fn.append(line, indent)
        local curpos = vim.fn.getcurpos()
        curpos[2] = curpos[2] + 1
        vim.fn.setpos(".", curpos)
        vim.fn.feedkeys("A")
    else
        -- cursor within the line
        vim.fn.feedkeys("a")
        vim.fn.feedkeys("\n")
    end
end

return {}
