-- ~/.config/nvim/lua/plugins/lsp/lspconfig.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-------------------------------------------------------------------
		---python
		-------------------------------------------------------------------
		lspconfig.pyright.setup({
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForType = true,
						typeCheckingMode = "basic",
					},
				},
			},
		})
		-------------------------------------------------------------------
		---lua
		-------------------------------------------------------------------
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})
		-------------------------------------------------------------------
		---rust 注释掉用rustaceanvim替换
		-------------------------------------------------------------------
		-- lspconfig.rust_analyzer.setup({
		-- 	capabilities = capabilities,
		-- 	settings = {
		-- 		["rust-analyzer"] = {
		-- 			checkOnSave = true,
		-- 			--{ command = "clippy", },
		-- 		},
		-- 	},
		-- })
	end,
}
