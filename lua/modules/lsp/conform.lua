return {
	'stevearc/conform.nvim',
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				["python"] = { "blue" },
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
				-- Timout of 1000 is better for larger files (than suggested 500)
				timeout_ms = 1000,
				lsp_fallback = true,
			},
		})
		vim.keymap.set("n", "<leader>c", ":lua require('conform').format({ timeout_ms = 100000 })<cr>",
			{ desc = "Format with conform with very long timeout" })
	end
}
