--代码格式化插件
return {
	"stevearc/conform.nvim",
	config = true,
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			python = { "isort", "black" },
			cs = { "csharpier" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
