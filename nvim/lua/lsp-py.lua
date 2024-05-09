local lspconfig = require("lspconfig")
local py = "/usr/bin/python3.11"
if vim.fn.has("win32") == 1 then
	py = "C:/Users/wg/AppData/Local/Programs/Python/Python312/python.exe"
end
lspconfig.pyright.setup({
	settings = {
		python = {
			pythonPath = py,
		},
	},
})
