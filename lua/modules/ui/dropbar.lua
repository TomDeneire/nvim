return {
  'Bekaboo/dropbar.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("dropbar").setup({
      icons = {
        kinds = {
          symbols = {
            Array = '󰅪 ',
            Boolean = ' ',
            BreakStatement = '󰙧 ',
            Call = '󰃷 ',
            CaseStatement = '󱃙 ',
            Class = ' ',
            Color = '󰏘 ',
            Constant = '󰏿 ',
            Constructor = ' ',
            ContinueStatement = '→ ',
            Copilot = ' ',
            Declaration = '󰙠 ',
            Delete = '󰩺 ',
            DoStatement = '󰑖 ',
            Enum = ' ',
            EnumMember = ' ',
            Event = ' ',
            Field = ' ',
            File = '󰈔 ',
            Folder = '󰉋 ',
            ForStatement = '󰑖 ',
            Function = '󰊕 ',
            Identifier = '󰀫 ',
            IfStatement = '󰇉 ',
            Interface = ' ',
            Keyword = '󰌋 ',
            List = '󰅪 ',
            Log = '󰦪 ',
            Lsp = ' ',
            Macro = '󰁌 ',
            MarkdownH1 = '󰉫 ',
            MarkdownH2 = '󰉬 ',
            MarkdownH3 = '󰉭 ',
            MarkdownH4 = '󰉮 ',
            MarkdownH5 = '󰉯 ',
            MarkdownH6 = '󰉰 ',
            Method = '󰆧 ',
            Module = '󰏗 ',
            Namespace = '󰅩 ',
            Null = '󰢤 ',
            Number = '󰎠 ',
            Object = '󰅩 ',
            Operator = '󰆕 ',
            Package = '󰆦 ',
            Property = ' ',
            Reference = '󰦾 ',
            Regex = ' ',
            Repeat = '󰑖 ',
            Scope = '󰅩 ',
            Snippet = '󰩫 ',
            Specifier = '󰦪 ',
            Statement = '󰅩 ',
            String = '󰉾 ',
            Struct = ' ',
            SwitchStatement = '󰺟 ',
            Terminal = ' ',
            Text = ' ',
            Type = ' ',
            TypeParameter = '󰆩 ',
            Unit = ' ',
            Value = '󰎠 ',
            Variable = '󰀫 ',
            WhileStatement = '󰑖 ',
          },
          use_devicons = true
        },
      }
    })
  end
}
