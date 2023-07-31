function get_color_opts(colorscheme)
    -- default = "Spunkshui"
    local bg          = "#303030"
    local white       = "#d4d4d4"
    local blue        = '#569cd6'
    local brightblue  = '#7bbad8'
    local red         = '#f44747'
    local orange      = '#ed872d'
    local yellow      = '#fac863'
    local green       = '#99c794'
    local cyan        = '#62b3b2'
    local purple      = '#c594c5'
    local brown       = '#ce9178'
    local brightwhite = '#ffffff'
    local grey        = '#a7adba'
    local selection   = '#C34043'
    local line_hl     = '#393836'

    if colorscheme == "Spunkshui" then
        bg          = "#303030"
        white       = "#d4d4d4"
        blue        = '#569cd6'
        brightblue  = '#7bbad8'
        red         = '#f44747'
        orange      = '#ed872d'
        yellow      = '#fac863'
        green       = '#99c794'
        cyan        = '#62b3b2'
        purple      = '#c594c5'
        brown       = '#ce9178'
        brightwhite = '#ffffff'
        grey        = '#a7adba'
        line_hl     = '#393836'
    elseif colorscheme == "Kanagawa" then
        bg          = "#2a2a2a"
        white       = "#DCD7BA" -- fujiWhite
        blue        = '#7FB4CA' -- springBlue
        brightblue  = '#A3D4D5' -- lightBlue
        red         = '#C34043' -- autumnRed
        orange      = '#FF9E3B' -- roninYellow
        yellow      = '#DCA561' -- autumnYellow
        green       = '#76946A' -- autumnGreen
        cyan        = '#7AA89F' -- waveAqua2
        purple      = '#957FB8' -- oniViolet
        brown       = '#FFA066' -- surimiOrange
        brightwhite = "#DCD7BA" -- fujiWhite
        grey        = '#717C7C' -- katanaGray
        selection   = '#2D4F67'
        line_hl     = '#393836'
    end

    return {
        keywordStyle = { italic = false },
        undercurl = false,
        transparent = false,
        theme = "dragon",
        background = { dark = bg },
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_dim = bg,
                        bg_gutter = bg,
                        bg_m3 = bg,
                        bg_m2 = bg,
                        bg_m1 = bg,
                        bg = bg,
                        bg_p1 = line_hl,
                        bg_p2 = line_hl, -- current line
                        bg_search = selection,
                        bg_visual = selection,
                        fg = white,
                        fg_dim = white,
                        pmenu = { fg = white },
                    }
                }
            }
        },
        overrides = function(
            colors)
            local theme = colors.theme
            return {
                -- Editor (see h: highlight-groups)
                CursorLineNR = { fg = white, bold = false },
                CursorLineNr = { fg = white, bold = false },
                IncSearch = { fg = white, bg = selection },
                MatchParen = { fg = orange },
                Search = { fg = white, bg = selection },
                NormalFloat = { fg = white, bg = line_hl }, -- e.g. whichkey
                FloatBorder = { bg = "none" },
                FloatTitle = { bg = "none" },
                NormalDark = { fg = white, bg = cyan },
                LazyNormal = { bg = line_hl, fg = white },
                MasonNormal = { bg = line_hl, fg = white },
                TelescopeTitle = { fg = white },
                TelescopePromptNormal = { bg = bg },
                TelescopePromptBorder = { fg = white, bg = bg },
                TelescopeResultsNormal = { fg = white, bg = bg },
                TelescopeResultsBorder = { fg = white, bg = bg },
                TelescopePreviewNormal = { bg = bg },
                TelescopePreviewBorder = { bg = bg, fg = white },
                Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                PmenuSel = { fg = "NONE", bg = selection },
                PmenuSbar = { bg = theme.ui.bg_m1 },
                PmenuThumb = { bg = theme.ui.bg_p2 },
                -- Syntax
                Annotation = { fg = white },
                Attribute = { fg = white },
                Boolean = { fg = cyan },
                Character = { fg = red, bold = false },
                ["@character.special"] = { fg = red, bold = false },
                Comment = { fg = green, italic = false },
                ["@conditional"] = { fg = purple },
                ["@conditional.ternary"] = { fg = purple },
                Constant = { fg = brightblue },
                ["@constant.builtin"] = { fg = brightblue },
                ["@constant.macro"] = { fg = brightblue },
                ["@constructor"] = { fg = yellow, bold = false },
                ["@constructor.lua"] = { fg = yellow, bold = false },
                Define = { fg = purple },
                Delimiter = { fg = yellow },
                ["@error"] = { fg = red, bold = true },
                ["@field"] = { fg = grey, bold = false },
                Float = { fg = green },
                Function = { fg = yellow },
                ["@function.call"] = { fg = yellow },
                ["@function.builtin"] = { fg = cyan },
                ["@function.macro"] = { fg = yellow },
                Fun = { fg = yellow },
                Identifier = { fg = white },
                Include = { fg = purple },
                Keyword = { fg = blue },
                ["@keyword.function"] = { fg = blue },
                ["@keyword.operator"] = { fg = blue, bold = false },
                ["@keyword.return"] = { fg = purple, bold = true },
                ["@keyword.luap"] = { fg = red },
                Label = { fg = yellow },
                Normal = { fg = white },
                Number = { fg = green },
                Method = { fg = red, bold = false },
                ["@method.call"] = { fg = yellow },
                ["@namespace"] = { fg = white, bold = false },
                Operator = { fg = yellow },
                ["@parameter"] = { fg = grey },
                ["@parameter.reference"] = { fg = grey },
                ["@property"] = { fg = grey },
                PreProc = { fg = yellow },
                Punctuation = { fg = yellow },
                ["@punctuation.delimiter"] = { fg = yellow },
                ["@punctuation.bracket"] = { fg = yellow },
                ["@punctuation.special"] = { fg = yellow },
                Repeat = { fg = purple },
                Regex = { fg = red, bold = false },
                Special = { fg = cyan },
                Special1 = { fg = cyan },
                Special2 = { fg = cyan },
                Special3 = { fg = cyan },
                SpecialChar = { fg = orange },
                Statement = { fg = red, bold = false },
                StorageClass = { fg = yellow },
                String = { fg = brown },
                ["@string.regex"] = { fg = red, bold = false },
                ["@string.escape"] = { fg = red, bold = false },
                ["@string.special"] = { fg = red, bold = false },
                Structure = { fg = green, bold = true },
                ["@symbol"] = { fg = cyan, bold = false },
                ["@tag"] = { fg = red },
                ["@tag.attribute"] = { fg = yellow },
                ["@tag.delimiter"] = { fg = yellow },
                Term = { fg = white },
                Text = { fg = white },
                ["@text.strong"] = { fg = white, bold = true },
                ["@text.emphasis"] = { fg = white, bold = true },
                ["@text.underline"] = { fg = white, underline = true },
                -- ["@text.strike"] = "TSStrike",
                ["@text.title"] = { fg = blue },
                ["@text.literal"] = { fg = brightblue },
                ["@text.uri"] = { fg = red },
                ["@text.math"] = { fg = red },
                ["@text.reference"] = { fg = white },
                ["@text.environment"] = { fg = white },
                ["@text.environment.name"] = { fg = orange },
                ["@text.note"] = { fg = white },
                ["@text.warning"] = { fg = orange },
                ["@text.danger"] = { fg = red, bold = false },
                Todo = { fg = yellow },
                Type = { fg = green, bold = true },
                ["@type.builtin"] = { fg = green, bold = true },
                ["@type.qualifier"] = { fg = green, bold = true },
                ["@type.definition"] = { fg = green, bold = true },
                Variable = { fg = white },
                ["@variable.builtin"] = { fg = cyan },
                -- QtechNG files types
                MumpsCommand = { fg = white, italic = true },
                MumpsLabel = { fg = blue, bold = true },
                MumpsGlobalName = { fg = blue },
                MumpsMacro = { fg = blue, italic = true },
                MumpsPName = { fg = brightblue, italic = true },
                MumpsUName = { fg = cyan, bold = true },
                MumpsCName = { fg = grey },
                MumpsFName = { fg = brightblue, bold = true },
                MumpsDoGoLabel = { fg = cyan, italic = true },
                MumpsLabelName = { fg = green, bold = true },
                MumpsIntrinsicFunction = { fg = cyan, italic = true },
                BfileValue = { fg = brightwhite },
                DfileInstruction = { fg = brightwhite, bold = true },
                DfileMacroLabel = { fg = blue, bold = true },
                DfileSynopsis = { fg = purple },
                DfileExample = { fg = yellow },
            }
        end,
    }
end

function ChangeColorScheme(color)
    vim.cmd("hi clear")
    vim.g.spunkshui_next_terminal_bold = 1
    vim.g.spunkshui_next_terminal_italic = 1
    vim.cmd.colorscheme(color)
    -- vim.g.syntax_on = 1

    -- removes tildes
    vim.cmd("set fillchars=eob:\\ ")

    -- nicer quickfix list (https://github.com/kevinhwang91/nvim-bqf)
    local fn = vim.fn

    function _G.qftf(info)
        local items
        local ret = {}
        -- The name of item in list is based on the directory of quickfix window.
        -- Change the directory for quickfix window make the name of item shorter.
        -- It's a good opportunity to change current directory in quickfixtextfunc :)
        --
        -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
        -- local root = getRootByAlterBufnr(alterBufnr)
        -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
        --
        if info.quickfix == 1 then
            items = fn.getqflist({ id = info.id, items = 0 }).items
        else
            items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
        end
        local limit = 31
        local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
        local validFmt = '%s │%5d:%-3d│%s %s'
        for i = info.start_idx, info.end_idx do
            local e = items[i]
            local fname = ''
            local str
            if e.valid == 1 then
                if e.bufnr > 0 then
                    fname = fn.bufname(e.bufnr)
                    if fname == '' then
                        fname = '[No Name]'
                    else
                        fname = fname:gsub('^' .. vim.env.HOME, '~')
                    end
                    -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                    if #fname <= limit then
                        fname = fnameFmt1:format(fname)
                    else
                        fname = fnameFmt2:format(fname:sub(1 - limit))
                    end
                end
                local lnum = e.lnum > 99999 and -1 or e.lnum
                local col = e.col > 999 and -1 or e.col
                local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
                str = validFmt:format(fname, lnum, col, qtype, e.text)
            else
                str = e.text
            end
            table.insert(ret, str)
        end
        return ret
    end

    vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
end

return {
    { 'rebelot/kanagawa.nvim', config = true, opts = get_color_opts("Spunkshui") } }
