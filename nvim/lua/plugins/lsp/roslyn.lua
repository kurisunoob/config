return {
	"seblj/roslyn.nvim",
	ft = "cs",
	dependencies = {
		-- 这里的 capabilities 依然复用你之前给 nvim-cmp 配置的那个
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local roslyn_dll = vim.fn.stdpath("data")
			.. "/mason/packages/roslyn/libexec/Microsoft.CodeAnalysis.LanguageServer.dll"
		if vim.fn.filereadable(roslyn_dll) == 0 then
			vim.notify("Roslyn DLL not found! Please check Mason installation.", vim.log.levels.ERROR)
			return
		end
		require("roslyn").setup({
			exe = { "dotnet", roslyn_dll },
			args = {
				"--logLevel=Information",
				"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
			},
			config = {
				-- 这里的 capabilities 确保补全正常
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				-- 启用 Inlay Hints (如参数名提示)
				settings = {
					["csharp|completion"] = {
						-- 开启未导入类型的补全建议 (关键！)
						dotnet_show_completion_items_from_unimported_namespaces = true,
						-- 输入符号时自动提供补全
						dotnet_provide_20_2_argument_completion = true,
					},
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = true,
					},
				},
			},
		})
	end,
}
