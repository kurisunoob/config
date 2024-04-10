require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"bash-language-server",
		"lua-language-server",
		"stylua",
		"pyright",
		"prettierd",
	},
})
