return {
	'stevearc/conform.nvim',
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "blue" },
				javascript = { "prettier" },
				["rust"] = { "rustfmt" },
				["javascript"] = { "prettier" },
				["javascriptreact"] = { "prettier" },
				["typescript"] = { "prettier" },
				["typescriptreact"] = { "prettier" },
				["vue"] = { "prettier" },
				["css"] = { "prettier" },
				["scss"] = { "prettier" },
				["less"] = { "prettier" },
				["html"] = { "prettier", "html" },
				["htmldjango"] = { "prettier", "html", "djlint" },
				["json"] = { "prettier" },
				["jsonc"] = { "prettier" },
				["yaml"] = { "prettier" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
				["graphql"] = { "prettier" },
				["handlebars"] = { "prettier" },
				["xml"] = { "xmlformatter" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
	end
}
